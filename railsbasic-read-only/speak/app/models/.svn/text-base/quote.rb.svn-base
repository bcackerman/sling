class Quote < ActiveRecord::Base
  belongs_to :user

  scope :show, where("removed_at IS NULL")
  scope :desc, order("created_at DESC")
  
  attr_accessible :author, :title, :content

  before_save :capitalize_name

  def capitalize_name
    self.title = self.title.titleize
    self.content = self.content.capitalize
  end

end
