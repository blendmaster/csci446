# -*- encoding : utf-8 -*-
Project03::Application.routes.draw do
  root to: 'store#index', as: 'store'
  resources :line_items
  resource :cart, only: :show do
	  post 'empty'
  end
  resources :products
end
