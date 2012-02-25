class Article < ActiveRecord::Base
    belongs_to :author
	validates :title, :body, :edits, :author, presence: true

	attr_protected :edits
	before_update {|article| article.edits += 1}
    
    self.per_page = 10
end
