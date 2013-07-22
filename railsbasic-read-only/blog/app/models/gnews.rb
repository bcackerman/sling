class Gnews < ActiveRecord::Base
  attr_accessible :text_entry, :language, :topic_id, :voice, :voice_played, :video

  mount_uploader :voice, NewsUploader

  # move this process into background job later
  # more audio signal processing can be added 
  #     normalize, trim off the silience at the begining and end
  #     noise profiling and background noise removal
  
  def self.convert_news_voice(record_file, dateid, tempfile)

    directory = "public/assets/news/voice/#{dateid}"

    # create the voice file path
    FileUtils.mkpath(directory)
    # combine voice file name
    news_wav = File.join(directory, tempfile)
    # write to the temp wav file
    File.open(news_wav, "wb") { |f| f.write(record_file['filename'].read) }

    # convert wav to mp3
    system "lame -V2 #{news_wav} #{news_wav}.mp3"
    # convert wav to ogg
    system "oggenc #{news_wav} #{news_wav}.ogg"

    # remove the temp wav file
    FileUtils.remove(news_wav)

  end
  
  def self.save_news_voice(dateid, newsid, tempfile)

    directory = "public/assets/news/voice/#{dateid}"

    # rename temp mp3 and ogg files
    FileUtils.move("#{directory}/#{tempfile}.mp3", "#{directory}/#{newsid}.mp3")
    FileUtils.move("#{directory}/#{tempfile}.ogg", "#{directory}/#{newsid}.ogg")

  end

end
