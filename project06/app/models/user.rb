class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # by default, for devise use (need :username for login)
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo
  
  # on creation
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo, as: :new_user

  # on user edit, restrict to these
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo, as: :member
  # admin can change everything
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :photo, :role_id, as: :admin
  
  validates :username, uniqueness: true, length: { minimum: 6 }
  validates_presence_of :username, :first_name, :last_name, :role
  
  has_attached_file :photo, styles: { thumb: '150x150' }

  has_many :games

  # I swear rails isn't caching this properly, because every
  # page load hits the Db for this. lameee
  belongs_to :role

  default_scope order: 'last_name ASC'

  def admin?
    role == Role.admin
  end
  def member?
    role == Role.member
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
