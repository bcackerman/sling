require 'carrierwave/video'
require 'streamio-ffmpeg'

class FileUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::Video
  include CarrierWave::MimeTypes
  # include CarrierWave::Video::Thumbnailer

  # process :set_content_type

  storage :fog

  process :get_duration

  process :get_screenshot

  version :mp4 do
    process :encode_video => [:mp4, resolution: "640x360", audio_codec: nil, custom: '-preset medium', callbacks: { after_transcode: :set_duration } ]
    def full_filename (for_file)
      "#{video_base_name}_video.mp4"
    end
  end

  version :ogg, :from_version => :mp4 do
    process :encode_ogv => [ callbacks: { after_transcode: :set_success } ]
    def full_filename (for_file)
      "#{video_base_name}_video.ogv"
    end
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.user_id}/#{model.id}"
  end

  def video_base_name
    model.file.filename
  end

  # version :poster do
  #   process :create_poster
  #   def full_filename (for_file)
  #     "#{video_base_name}_poster.jpg"
  #   end
  # end

  # def create_poster
  #   cached_stored_file! if !cached?
  #   tmp_path = File.join( File.dirname(current_path), "screenshot.jpg" )
  #   movie = FFMPEG::Movie.new(current_path)
  #   model.screenshot = movie.screenshot(tmp_path).path #, {:seek_time => 5, :resolution => '320x240'}, preserve_aspect_ratio: :width)
  #   File.rename tmp_path, current_path
  # end

  def get_screenshot
    movie = FFMPEG::Movie.new(current_path)
    model.screenshot = movie.screenshot("#{Rails.root}/tmp/uploads/screenshot.jpg", { seek_time: 2, resolution: '320x240' }, preserve_aspect_ratio: :width)
  end

  def get_duration
    cached_stored_file! if !cached?
    movie = FFMPEG::Movie.new(current_path)
    model.length = movie.duration
  end

end
