class User < ActiveRecord::Base
	attr_accessible :name, :password, :password_confirmation
	has_secure_password
	validates_presence_of :password, :password_confirmation, :name, on: :create
	validates_uniqueness_of :name

	after_destroy :ensure_an_admin_remains

	def ensure_an_admin_remains
		raise "Can't delete last user" if User.count.zero?
	end
end
