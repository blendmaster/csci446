class Article < ActiveRecord::Base
	validates :title, :author, :body, presence: true
	validates :author, format: { without: /pat/i, message: "Your kind isn't allowed here, Pat!" }
end
