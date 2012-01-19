# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_cart
	if session[:cart_id]
    	return Cart.find session[:cart_id]
	else
		cart = Cart.create
		session[:cart_id] = cart.id
		return cart
	end
  end
end
