class Game < ActiveRecord::Base
  attr_accessible :title, :rating
  attr_accessible :title, :rating, :user_id, as: :admin

  validates_presence_of :title

  enum_attr :rating, %w[Amazing Good Meh Horrible]
  
  default_scope order: 'created_at DESC'
  
  @per_page = 10 # for will_paginate
  
  belongs_to :user
  
  def to_s
    title
  end
end
