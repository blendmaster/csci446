class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		item = line_items.where(product_id: product_id).first_or_initialize
		item.quantity += 1
		return item
	end
end
