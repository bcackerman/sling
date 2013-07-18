require 'carrierwave/processing/mini_magick'

#################################################################
# Mini_magick not working under Windows because of escape chars
# Dirty solution until Shellwords windows bug is fixed
require 'rbconfig'
is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

if is_windows
  class MiniMagick::CommandBuilder
    def escape_string( value )
      return '"' + value.gsub( '\\', '\\\\' ).gsub( '"', '\\"' ) + '"'
    end
  end
end
#################################################################

class AvatarUploader < CarrierWave::Uploader::Base

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  include ::CarrierWave::Backgrounder::Delay
  process :set_content_type

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
  version :large do
    resize_to_limit(500, 500)
  end

  version :thumb do
    process :crop
    resize_to_fill(128, 128)
  end
  
  def crop
    if model.crop_x.present?
      resize_to_limit(500, 500)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        args = [ w, 'x', h, '+', x, '+', y ].join('')
        img.crop(args)
        img
      end
    end
  end

end

