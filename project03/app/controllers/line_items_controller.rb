class LineItemsController < ApplicationController
  respond_to :html, :json

  def create
    @line_item = current_cart.add_product params[:product_id]
	
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_url, notice: "#{@line_item} successfully added to cart." }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to cart_url, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_url}
      format.json { head :no_content }
    end
  end
end
