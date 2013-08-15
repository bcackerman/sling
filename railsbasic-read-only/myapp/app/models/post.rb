class Post < ActiveRecord::Base
  attr_accessible :text_entry, :language, :topic_id, :voice
  belongs_to :user

  mount_uploader :voice, VoiceUploader

  # move this process into background job later
  def self.save_record_voice(record_file, name)
    directory = "public/assets/user_voices/"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(record_file['filename'].read) }
   
    # convert to mp3
    system "#{RAILS_ROOT}/public/library/lame/lame #{path} #{path}_tmp.mp3"
  
    # normalize, trim off the silience at the begining and end
    system "#{RAILS_ROOT}/public/library/sox/sox #{path}_tmp.mp3 #{path}.mp3 norm vad reverse vad reverse"

    # below is for background noise removal
    # get noise profile first
    #system "#{RAILS_ROOT}/public/library/sox/sox #{path}_tmp.mp3 -n trim 0 1 noiseprof #{path}.np"
    # remove the background noise
    #system "#{RAILS_ROOT}/public/library/sox/sox #{path}_tmp.mp3 #{path}.mp3 noisered #{path}.np 0.3 norm vad reverse vad reverse"

    # remove the temp files
    #system "rm #{path} #{path}.np #{path}_tmp.mp3"
    system "rm #{path} #{path}_tmp.mp3"
  end
  
end
