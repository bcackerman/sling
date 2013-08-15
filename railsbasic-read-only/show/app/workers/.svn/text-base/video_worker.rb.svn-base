require 'open-uri'

class VideoWorker
  PRESET_ID_WEB = '1351620000000-100070'
  PIPELINE_ID = '1360441147318-cdab24'
  INPUT_KEY_S3 = 'videos/uploads/20130208T2324Z_547d350ae0658bf5c734888032d40011/sample_iTunes.mov'
  OUTPUT_KEY_S3 = 'videos/media/sample_iTunes_0000.mp4'

  def self.convert()

    transcoder = AWS::ElasticTranscoder::Client.new
    transcoder.create_job(
      pipeline_id: PIPELINE_ID,
      input: {
        key: INPUT_KEY_S3,
        frame_rate: 'auto',
        resolution: 'auto',
        aspect_ratio: 'auto',
        interlaced: 'auto',
        container: 'auto'
      },
      output: {
        key: OUTPUT_KEY_S3,
        preset_id: PRESET_ID_WEB,
        thumbnail_pattern: "",
        rotate: '0'
      }
    )
    
  end
end

