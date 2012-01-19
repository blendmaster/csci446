class CartsController < ApplicationController
  respond_to :html

  def show
	  @cart = current_cart 
  end

  def empty
	  if current_cart.line_items.delete_all
		  redirect_to cart_url, notice: "Cart emptied."
	  else
		  redirect_to cart_url, notice: "Cart could not be emptied!"
	  end
  end
end
