class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :username, :avatar, :password, :password_confirmation, :remember_me

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :minimum => 6, :maximum => 20
  validates_length_of :email, :maximum => 32
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false
  validates_length_of :password, :minimum => 4, :allow_blank => false
  validates_confirmation_of :password
  #validates :email, :email_format => true

  has_many :questions
  has_many :answers
  has_many :evaluations

  # mount_uploader :avatar, AvatarUploader
  # validates_integrity_of :avatar
  # validates_processing_of :avatar

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

end
