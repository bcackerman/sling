# encoding: utf-8

class VoiceUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "assets/user/voice/#{model.user_id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(wav mp3 ogg)
   end

  # Override the filename of the uploaded files:
  def filename
    "#{model.id}.mp3" if original_filename
  end

end
