class Author < ActiveRecord::Base
  has_many :articles
  has_attached_file :photo, styles: { medium: '450x450', thumb: '128x128' }
  validates :name, presence: true, uniqueness: true, format: { without: /pat/i, message: "Your kind isn't allowed here, Pat!" }
end
