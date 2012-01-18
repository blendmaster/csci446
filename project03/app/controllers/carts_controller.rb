class CartsController < ApplicationController
  respond_to :html, :json

  def show
	  respond_with @cart = current_cart do |format|
		  format.json { render json: @cart.to_json( include: :line_items ) }
	  end
  end
end
