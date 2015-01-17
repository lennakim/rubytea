class ActionDispatch::Routing::Mapper
  def draw(routes_name)
  instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do


  get 'home/index'

  devise_for :users, path: "account"

  resources :users, only: [:show, :edit, :update]

  resources :events, only: [:index, :show ] do
    resources :comments
  end


  root 'home#index'
  draw :admin
end
