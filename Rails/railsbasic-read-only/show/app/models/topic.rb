class Topic < ActiveRecord::Base
  has_many :posts
  attr_accessible :age_group, :content, :title


end
