# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
Role.create! name: "Admin"
Role.create! name: "Member"

User.create! username: 'member', password: 'password', password_confirmation: 'password', first_name: 'Joe', last_name: 'Bob', role: Role.member, email: 'a@b.c'
User.create! username: 'administrator', password: 'password', password_confirmation: 'password', first_name: 'Jim', last_name: 'Bob', role: Role.admin, email: 'b@c.d'
