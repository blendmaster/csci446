# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
require 'wordy'

def words num
	Wordy.words(num).map(&:capitalize).join(" ")
end

# add some authors
10.times do |i|
  Author.create! name: words(2), photo: File.open("db/seed_images/#{i}.jpg")
end

150.times do
	Article.create! title: words(3), author: Author.find(Random.rand(1..10)), body: Wordy.paragraphs(5).join("\n\n")
end
