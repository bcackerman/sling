class Evaluation < ActiveRecord::Base
  attr_accessible :content, :liked, :voice
  belongs_to :user
  belongs_to :answer
  
end
