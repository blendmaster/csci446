# -*- encoding : utf-8 -*-
class StoreController < ApplicationController
  def index
	  @cart = current_cart
  end
end
