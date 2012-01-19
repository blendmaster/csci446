# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_cart
	Cart.find_or_create_by_id(session[:cart_id]).tap do |cart|
		session[:cart_id] = cart.id unless session[:cart_id]
	end
  end
end
