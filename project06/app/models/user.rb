class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # as regular user
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo
  
  # on creation
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo, as: :new_user

  # users can't change these
  attr_accessible :username, :role, as: :admin
  
  validates :username, uniqueness: true, length: { minimum: 6 }
  validates_presence_of :username, :first_name, :last_name, :role
  
  has_attached_file :photo, styles: { thumb: '150x150' }

  has_many :games

  belongs_to :role

  def admin?
    role == Role.admin
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
