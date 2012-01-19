# -*- encoding : utf-8 -*-
Project03::Application.routes.draw do
	root to: 'store#index', as: 'store'
	get "register" => "users#new", as: :register 
	post "register" => "users#create", as: :register
	resources :users
	resources :orders
	resource :cart, only: :show do
		resources :line_items, only: [:update, :destroy]
		post 'add/:product_id', action: :add, as: :add_to
		post 'empty'
	end
	resources :products do
		get :who_bought, on: :member
	end
end
