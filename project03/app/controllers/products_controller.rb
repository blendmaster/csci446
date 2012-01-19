# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController
	skip_before_filter :authorize, only: [:index, :show]
	respond_to :html

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def edit
		@product = Product.find(params[:id])
	end

	def create
		@product = Product.new(params[:product])
		if @product.save
			redirect_to @product, notice: 'Product was successfully created.'
		else 
			render action: "new"
		end
	end

	def update
		@product = Product.find(params[:id])

		if @product.update_attributes(params[:product])
			redirect_to @product, notice: 'Product was successfully updated.' 
		else
			render action: "edit" 
		end
	end

	def destroy
		Product.find(params[:id]).destroy

		redirect_to products_url
	end

	def who_bought
		@product = Product.find(params[:id])
		respond_to do |format|
			format.atom
		end
	end
end
