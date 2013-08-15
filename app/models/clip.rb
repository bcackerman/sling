# == Schema Information
#
# Table name: clips
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  file              :string(255)
#  shortlink         :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  length            :integer
#  screenshot        :string(255)
#  impressions_count :integer          default(0)
#

class Clip < ActiveRecord::Base
  attr_accessible :file, :name, :shortlink, :user_id, :screenshot, :length, :impressions_count

  mount_uploader :file, FileUploader
  mount_uploader :screenshot, ScreenshotUploader

  belongs_to :user

  validates :shortlink, presence: true, uniqueness: true
  validates_presence_of :user_id

  before_validation :generate_shortlink, on: :create
  before_validation :set_user_id, on: :create

  is_impressionable :counter_cache => true

  def set_success(format, opts)
    puts "Success uploading"
  end
  
  def set_duration(format, opts)
  end


  protected
    def generate_shortlink
      self.shortlink = SecureRandom.hex(3)
    end

    def set_user_id
      user_id = User.where(token: token).first
    end 
end
