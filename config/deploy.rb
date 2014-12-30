require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :domain, '104.131.132.152'
set :user, 'deploy'

set :deploy_to, '/home/deploy/www/rubytea'
set :current_path, 'current'
set :app_path,  "#{deploy_to}/#{current_path}"

set :repository, 'git@github.com:sundevilyang/rubytea.git'
set :branch, 'master'
set :keep_releases, 20
set :forward_agent, true  # SSH forward_agent.

set :unicorn_pid, lambda { "#{deploy_to}/#{shared_path}/tmp/pids/unicorn.pid" }

set :shared_paths, ['config/database.yml', 'log']

task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

namespace :unicorn do
  desc "Start Unicorn"
  task start: :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! %{
      cd #{app_path}
      bundle exec unicorn_rails -E production -c config/unicorn.rb -D
    }
  end

  desc "Stop Unicorn"
  task stop: :environment do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      test -s "#{unicorn_pid}" && kill -QUIT `cat "#{unicorn_pid}"` && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end

  desc "Restart Unicorn"
  task restart: :environment do
    invoke :'unicorn:stop'
    invoke :'unicorn:start'
  end
end

namespace :assets do
  desc "assets clear"
  task clear: :environment do
    queue  %{
      cd #{app_path}
      bundle exec rake assets:clobber RAILS_ENV=production
    }
  end
end
