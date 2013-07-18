require 'carrierwave/video'
require 'streamio-ffmpeg'

class VideoUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::Video
  include CarrierWave::MimeTypes
  include CarrierWave::Backgrounder::Delay

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    #%w(3g2 3gp avi flv m2v m4v mov mp4 mpeg webm wmv)
    %w(mp4)
  end
  
  version :mp4 do
    process :set_content_type
    process :set_duration
    #process :encode_video => [:mp4,
    #                          resolution: "640x360",
    #                          audio_codec: nil,
    #                          custom: '-preset medium']

    def full_filename (for_file)
      parent_name = super(for_file)
      ext         = File.extname(parent_name)
      base_name   = parent_name.chomp(ext)
      [base_name, version_name].compact.join('.')
    end

    def set_content_type(*args)
      self.file.instance_variable_set(:@content_type, "video/mp4")
    end
  end

  version :poster do
    process :set_content_type
    process :create_poster

    def full_filename (for_file)
      parent_name = super(for_file)
      ext         = File.extname(parent_name)
      base_name   = parent_name.chomp(ext)
      [base_name, 'jpg'].compact.join('.')
    end

    def set_content_type(*args)
      self.file.instance_variable_set(:@content_type, "image/jpg")
    end
  end

  def create_poster
    cached_stored_file! if !cached?
    tmp_path = File.join( File.dirname(current_path), "screenshot.jpg" )
    movie = FFMPEG::Movie.new(current_path)
    movie.screenshot(tmp_path, :seek_time => 30, :resolution => '320x180')
    File.rename tmp_path, current_path
  end

  def set_duration
    cached_stored_file! if !cached?
    movie = FFMPEG::Movie.new(current_path)
    post = Post.find(model.id)
    post.update_attribute(:length, movie.duration.to_i)
  end

end

