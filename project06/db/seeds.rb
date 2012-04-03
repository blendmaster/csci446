# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Role.find_or_create_by_name "Admin"
Role.find_or_create_by_name "Member"

User.create({ username: 'member', password: 'password', password_confirmation: 'password', first_name: 'Joe', last_name: 'Bob', role: Role.member, email: 'a@b.c' }, without_protection: true)
User.create( {username: 'administrator', password: 'password', password_confirmation: 'password', first_name: 'Jim', last_name: 'Bob', role: Role.admin, email: 'b@c.d'}, without_protection: true)

# add some games
require 'wordy'

ratings = %w[Amazing Good Meh Horrible]

users = User.all.map &:id
50.times do |i|
  Game.create!({title: Wordy.words(1).join(" "), rating: ratings.sample, user_id: users.sample}, without_protection: true)
end
