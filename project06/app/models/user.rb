class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name, :photo, :role

  validates_presence_of :username, :email, :first_name, :last_name, :password, :role
  
  validates :username, uniqueness: true, length: { minimum: 6 }
  validates :password, length: { minimum: 6 }, confirmation: true
  
  has_attached_file :photo, styles: { thumb: "150x150" }
  
  enum_attr :role, %w[Member Admin]
  acts_as_authentic
end
