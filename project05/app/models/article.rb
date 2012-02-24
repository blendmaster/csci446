class Article < ActiveRecord::Base
	validates :title, :author, :body, :edits, presence: true
	validates :author, format: { without: /pat/i, message: "Your kind isn't allowed here, Pat!" }

	attr_protected :edits
	before_update {|article| article.edits += 1}
end
