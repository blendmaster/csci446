# -*- encoding : utf-8 -*-
Project03::Application.routes.draw do
	root to: 'store#index'
	get "store" => "store#index"
	get "admin" => "admin#index"

	resources :users

	controller :sessions do
		get 'login' => :new
		post 'login' => :create
		get 'logout' => :destroy
	end
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
