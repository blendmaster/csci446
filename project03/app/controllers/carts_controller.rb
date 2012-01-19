class CartsController < ApplicationController
  respond_to :html, :json

  def show
	  respond_with @cart = current_cart do |format|
		  format.json { render json: @cart.to_json( include: :line_items ) }
	  end
  end

  def empty
	  if current_cart.line_items.delete_all
		  redirect_to cart_url, notice: "Cart emptied."
	  else
		  redirect_to cart_url, notice: "Cart could not be emptied!"
	  end
  end
end
