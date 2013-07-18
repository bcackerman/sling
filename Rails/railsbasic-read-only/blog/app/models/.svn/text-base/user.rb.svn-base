class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :username, :avatar, :gravatar, :password, :password_confirmation, :remember_me

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :minimum => 6, :maximum => 20
  validates_length_of :email, :maximum => 32
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false
  validates_length_of :password, :minimum => 4, :allow_blank => false
  validates_confirmation_of :password
  validates :email, :email_format => true
  validates_format_of :gravatar, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :update, :allow_blank => true

  has_many :posts
  has_many :questions
  has_many :answers
  has_many :evaluations
  has_many :friendships, :order => "refreshed_at DESC"
  has_many :friends, :through => :friendships

  mount_uploader :avatar, AvatarUploader
  validates_integrity_of :avatar
  validates_processing_of :avatar

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

end
