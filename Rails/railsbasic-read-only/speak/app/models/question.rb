class Question < ActiveRecord::Base
  has_many :posts
  belongs_to :user
  belongs_to :subject

  scope :show, where("removed_at IS NULL")
  scope :desc, order("created_at DESC")
  scope :answer, select("questions.*, COUNT(posts.id) AS answers_count").joins("LEFT OUTER JOIN posts ON questions.id = posts.question_id").group('questions.id')

  attr_accessible :title, :content, :subject_id

  validates :content, :presence => true, :length => { :minimum => 10, :maximum => 200 }

  before_save :capitalize_name

  extend FriendlyId
  friendly_id :content, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
    
  def capitalize_name
    self.title = self.title.titleize
    self.content = self.content.capitalize
  end

end
