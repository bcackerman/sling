class Order < ActiveRecord::Base
  belongs_to :users
  belongs_to :pubs
  belongs_to :drinks
end
