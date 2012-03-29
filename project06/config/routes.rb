Gamez::Application.routes.draw do
  get "register" => 'users#new'
  post "register" => 'users#create'
  
  # formtastic needs users_path ;_;
  resources :users, only: [:new, :create]

  get "login" => 'user_sessions#new'
  post "login" => 'user_sessions#new'

  root to: 'application#index'
end
