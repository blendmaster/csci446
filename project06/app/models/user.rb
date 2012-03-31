class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :photo, :role
  
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
