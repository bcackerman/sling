class Answer < ActiveRecord::Base
  attr_accessible :content, :listened, :liked, :voice
  belongs_to :user
  belongs_to :question
  has_many :evaluations
  
  mount_uploader :voice, VoiceUploader

  # move this process into background job later
  # more audio signal processing can be added 
  #     normalize, trim off the silience at the begining and end
  #     noise profiling and background noise removal
  
  def self.convert_user_voice(record_file, userid, tempfile)

    directory = "public/assets/user/voice/#{userid}"

    # create the voice file path
    FileUtils.mkpath(directory)
    # combine voice file name
    voice_wav = File.join(directory, tempfile)
    # write to the temp wav file
    File.open(voice_wav, "wb") { |f| f.write(record_file['filename'].read) }

    # convert wav to mp3
    system "lame -V2 #{voice_wav} #{voice_wav}.mp3"
    # convert wav to ogg
    system "oggenc #{voice_wav} #{voice_wav}.ogg"

    # remove the temp wav file
    FileUtils.remove(voice_wav)

  end
 
  def self.save_user_voice(userid, postid, tempfile)

    directory = "public/assets/user/voice/#{userid}"

    # rename temp mp3 and ogg files
    FileUtils.move("#{directory}/#{tempfile}.mp3", "#{directory}/#{postid}.mp3")
    FileUtils.move("#{directory}/#{tempfile}.ogg", "#{directory}/#{postid}.ogg")

  end

end
