class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :avatar, :password, :password_confirmation, :remember_me

  has_many :posts
  has_many :friendships, :order => "created_at DESC"
  has_many :friends, :through => :friendships

  mount_uploader :avatar, AvatarUploader

end
