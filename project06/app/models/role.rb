class Role < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :users

  def to_s
    name
  end

  def self.admin
    where('name = "Admin"').first
  end

  def self.member
    where('name="Member"').first
  end
end

