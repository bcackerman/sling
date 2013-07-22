require 'carrierwave/video'
require 'streamio-ffmpeg'

class VideoUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::Video
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.user_id}/#{model.id}"
  end

  process :set_content_type
  process :set_duration

  version :poster do
    process :create_poster
    def full_filename (for_file)
      parent_name = super(for_file)
      ext         = File.extname(parent_name)
      base_name   = parent_name.chomp(ext)
      base_name + '.jpg'
    end
  end

  version :mp4 do
    process :encode_video => [:mp4,
                              resolution: "640x360",
                              audio_codec: nil,
                              custom: '-preset medium']
    def full_filename (for_file)
      parent_name = super(for_file)
      ext         = File.extname(parent_name)
      base_name   = parent_name.chomp(ext)
      [base_name, version_name].compact.join('.')
    end
  end

  #version :ogv, :from_version => :mp4 do
  #  process :encode_ogv => [ callbacks: { after_transcode: :set_success } ]
  #  def full_filename (for_file)
  #    parent_name = super(for_file)
  #    ext         = File.extname(parent_name)
  #    base_name   = parent_name.chomp(ext)
  #    [base_name, version_name].compact.join('.')
  #  end
  #end

  private
  def create_poster
    cached_stored_file! if !cached?
    tmp_path = File.join( File.dirname(current_path), "screenshot.jpg" )
    movie = FFMPEG::Movie.new(current_path)
    movie.screenshot(tmp_path, :seek_time => 5, :resolution => '320x180')
    File.rename tmp_path, current_path
  end

  def set_duration
    cached_stored_file! if !cached?
    movie = FFMPEG::Movie.new(current_path)
    model.length = movie.duration
  end

end

