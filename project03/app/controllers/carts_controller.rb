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

  def add
	@line_item = current_cart.add_product params[:product_id]
	if @line_item.save
		respond_to do |format|
			format.html { redirect_to cart_url, notice: "#{@line_item} successfully added to cart." }
			format.js
		end
	end
  end
end
