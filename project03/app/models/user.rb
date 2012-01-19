class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation
	has_secure_password
	validates_presence_of :password, :password_confirmation, :name, on: :create
	validates_uniqueness_of :name
end
