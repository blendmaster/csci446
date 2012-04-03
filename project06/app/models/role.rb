class Role < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :users

  default_scope order: 'name ASC'

  def to_s
    name
  end

  def self.admin
    @@admin_role ||= where('name = "Admin"').first
  end

  def self.member
    @@member_role ||= where('name="Member"').first
  end
end

