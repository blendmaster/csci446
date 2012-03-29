Gamez::Application.routes.draw do
  devise_for :users, path: 'members', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root to: 'games#index'
end
