class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		line_items.find_or_initialize_by_product_id(product_id).tap do |item|
			item.quantity += 1
		end
	end

	def total_price
		line_items.sum &:total_price
	end

	def empty?
		line_items.empty?
	end

	def empty!
		line_items.destroy_all
	end
end
