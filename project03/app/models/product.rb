# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :image_url, format: {
		with: %r{\.(gif|jpg|png)$}i,
		message: 'must be a gif, jpg, or png image.'
	}
	default_scope order: 'title'

	has_many :line_items
	before_destroy :ensure_not_in_line_items
		   
	private
			 
	def ensure_not_in_line_items
		errors.add( :base, 'This product is present in existing Carts!') and return false unless line_items.empty?
	end

end
