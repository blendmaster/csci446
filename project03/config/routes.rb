# -*- encoding : utf-8 -*-
Project03::Application.routes.draw do
  root to: 'store#index', as: 'store'
  resource :cart, only: :show do
	  resources :line_items, only: [:update, :destroy]
	  post 'add/:product_id', action: :add, as: :add_to
	  post 'empty'
  end
  resources :products
end
