class Pub < ActiveRecord::Base

  has_and_belongs_to_many :drinks
  has_many :orders

  mount_uploader :logo,   PhotoUploader
  mount_uploader :photo1, PhotoUploader
  mount_uploader :photo2, PhotoUploader
  mount_uploader :photo3, PhotoUploader
  mount_uploader :photo4, PhotoUploader
  mount_uploader :photo5, PhotoUploader

end
