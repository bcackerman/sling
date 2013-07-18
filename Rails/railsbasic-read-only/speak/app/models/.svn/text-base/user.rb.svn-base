class User < ActiveRecord::Base
  easy_roles :roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :speeches
  has_many :posts
  has_many :questions
  has_many :likes
  has_many :ratings
  has_many :feedbacks

  # Setup accessible (or protected) attributes for your model
  attr_protected :roles
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :avatar, :name, :memo, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessible :avatar_cloud

  validates :email, :presence => true
  validates :email, :uniqueness => { :case_sensitive => false }

  validates :name, :presence => true
  validates :name, :uniqueness => { :case_sensitive => false }
  validates :name, :length => { :minimum => 6, :maximum => 20 }
  validates :name, :format => { :with => /^[A-Za-z][A-Za-z0-9]*$/ }
  validates :name, :exclusion => {:in => ["admin", "admins", "administrator", "administrators", "root",
                          "signup", "signin", "upload", "featured", "ratings",
                          "posts", "questions", "speeches", "quotes", "users", "groups", "feedbacks"],
                          :message => "This username is a reserved word."}

  mount_uploader :avatar, AvatarUploader
  #process_in_background :avatar

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  
  before_create :setup_defaults

  extend FriendlyId
  friendly_id :name, use: :slugged

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def setup_defaults
    self.slug = self.name
  end

  def has_like? post
    likes.find_by_post_id post.id
  end

  def has_rate? post
    ratings.find_by_post_id post.id
  end
end
