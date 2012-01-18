class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		item = line_items.find_or_initialize_by_product_id product_id
		item.quantity += 1
		return item
	end
end
