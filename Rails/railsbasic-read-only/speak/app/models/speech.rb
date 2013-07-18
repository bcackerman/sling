class Speech < ActiveRecord::Base
  belongs_to :user

  scope :show, where("removed_at IS NULL")
  scope :desc, order("created_at DESC")

  attr_accessible :video_url, :poster_url, :avatar_url, :speaker, :delivered_by
  attr_accessible :objective, :title, :content, :length, :views

  before_save :capitalize_name

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end

  def capitalize_name
    self.title = self.title.titleize
    self.content = self.content.capitalize
  end

end
