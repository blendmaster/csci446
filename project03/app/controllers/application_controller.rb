# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :authorize

	private

	def current_cart
		Cart.find_or_create_by_id(session[:cart_id]).tap do |cart|
			session[:cart_id] = cart.id unless session[:cart_id]
		end
	end

	def current_user
		User.find session[:user_id] if logged_in?
	end

	def logged_in?
		!! session[:user_id]
	end

	helper_method :current_cart, :logged_in?, :current_user

	protected

	def authorize
		redirect_to login_url, notice: "Please log in" unless logged_in?
	end
end
