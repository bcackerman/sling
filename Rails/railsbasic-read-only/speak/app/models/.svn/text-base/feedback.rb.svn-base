class Feedback < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :content
  validates :content, :presence => true, :length => { :minimum => 10, :maximum => 512 }
end
