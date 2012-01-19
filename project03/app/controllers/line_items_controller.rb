class LineItemsController < ApplicationController
	respond_to :html,:js

	def update
		@line_item = LineItem.find(params[:id])

		if @line_item.update_attributes(params[:line_item])
			respond_with do |format|
				format.html { redirect_to cart_url, notice: 'Line item was successfully updated.' }
			end
		end
	end

	def destroy
		@line_item = LineItem.find(params[:id])
		if @line_item.destroy
			respond_with do |format|
				format.html { redirect_to cart_url, notice: "line item was removed from your cart." }
			end
		end
	end
end
