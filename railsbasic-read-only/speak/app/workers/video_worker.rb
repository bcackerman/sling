class VideoWorker < ::CarrierWave::Workers::ProcessAsset

  def success(job)
    post = Post.find_by_id(get_id(job))
    post.update_attribute(:processed, true)
  end

  def error(job, exception)
    post = Post.find_by_id(get_id(job))
    post.update_attribute(:processed, false)
  end

  def get_id(job)
    job.handler.split("\n")[2].gsub("id: '","").to_i
  end
end

