# -*- encoding : utf-8 -*-
class StoreController < ApplicationController
  def index
	  @products = Product.all
  end
end
