class Post < ActiveRecord::Base
  has_many :likes
  has_many :ratings
  belongs_to :user
  belongs_to :question
  belongs_to :objective
  
  accepts_nested_attributes_for :ratings

  scope :show, where(:success => true).where(:processed => true).where("removed_at IS NULL")
  scope :desc, order("created_at DESC")
  scope :like, select("posts.*, COUNT(likes.id) AS likes_count").joins("LEFT OUTER JOIN likes ON posts.id = likes.post_id").group('posts.id')

  attr_accessible :video, :success, :privacy, :title, :content, :objective_id, :question_id, :speech_id, :category, :views, :length, :ratings_attributes
  attr_accessible :video_cloud, :poster_cloud

  validates :title, :presence => true, :length => { :minimum => 10, :maximum => 128 }
  validates :content, :presence => true, :length => { :minimum => 10, :maximum => 512 }

  mount_uploader :video, VideoUploader
  process_in_background :video, VideoWorker

  before_validation :setup_defaults, :on => :create
  before_save :capitalize_name

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  #def should_generate_new_friendly_id?
  #  new_record?
  #end

  def setup_defaults
    self.title = "No title yet."
    self.content = "No description yet."
    self.length = 0
  end

  def capitalize_name
    self.title = self.title.titleize
    self.content = self.content.capitalize
  end

end
