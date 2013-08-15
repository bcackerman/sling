class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  belongs_to :topic
  belongs_to :category
  belongs_to :skill
  
  scope :show, where(:success => true).where("removed_at IS NULL")
  scope :desc, order("created_at DESC")

  attr_accessible :video, :success, :privacy, :title, :content, :category_id, :skill_id, :views, :likes, :length

  mount_uploader :video, VideoUploader

  before_create :setup_defaults

  def setup_defaults
    self.title = "New upload"
  end

end
