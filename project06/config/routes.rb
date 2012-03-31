Gamez::Application.routes.draw do
  devise_for :users, path: 'members', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: "registrations", sessions: "sessions"}
  
  
  namespace :members do
    resources :games
    get 'me' => 'members#edit', as: 'me'
    put 'me' => 'members#update', as: 'me'
  end
  
  get 'members' => 'members/games#index'

  root to: 'games#index'
end
