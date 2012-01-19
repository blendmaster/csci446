class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :cart
	belongs_to :order

	def total_price
		product.price * quantity
	end

	def to_s
		product.title
	end
end
