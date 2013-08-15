class Question < ActiveRecord::Base
  attr_accessible :content, :liked, :voice
  belongs_to :user
  has_many :answers

end
