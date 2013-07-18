# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "assets/user_images/avatars/#{model.id}"
  end

  # Process files as they are uploaded:
  #process :scale => [96, 96]

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg png)
  end

end
