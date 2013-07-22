class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :registerable, :recoverable, 
  # :rememberable, :validatable and :omniauthable
  devise :database_authenticatable, :trackable, :timeoutable, :lockable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :username, :password, :password_confirmation
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :minimum => 6, :maximum => 20
  validates_length_of :email, :maximum => 32
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false
  validates_length_of :password, :minimum => 8, :allow_blank => false
  validates_confirmation_of :password

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

end
