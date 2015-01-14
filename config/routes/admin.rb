namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard

  resources :users
  resources :events

end