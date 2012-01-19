class OrdersController < ApplicationController
	respond_to :html
	def index
		@orders = Order.page params[:page]
	end

	def show
		@order = Order.find(params[:id])
	end

	def new
		return redirect_to store_url, notice: "Your Cart is empty" if current_cart.empty?
		@order = Order.new
	end

	def edit
		@order = Order.find(params[:id])
	end

	def create
		@order = Order.new(params[:order])
		@order.add_line_items_from_cart current_cart
		if @order.save
			redirect_to store_url, notice: 'Thank you for your order.'
		else
			render action: "new" 
		end
	end

	def update
		@order = Order.find(params[:id])

		respond_to do |format|
			if @order.update_attributes(params[:order])
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy

		respond_to do |format|
			format.html { redirect_to orders_url }
			format.json { head :no_content }
		end
	end
end
