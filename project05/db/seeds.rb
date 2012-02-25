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
15.times do
  Author.create! name: words(2)
end

150.times do
	Article.create! title: words(3), author: Author.find(Random.rand(1..15)), body: Wordy.paragraphs(5).join("\n\n")
end
