Gamez::Application.routes.draw do
  devise_for :users, path: 'members', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations"}
  
  
  namespace :members do
    resources :games
    get 'me' => 'settings#edit'
    put 'me' => 'settings#update'
  end
  
  get 'members' => 'members/games#index'

  root to: 'games#index'
end
