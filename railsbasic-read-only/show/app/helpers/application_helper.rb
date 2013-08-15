module ApplicationHelper
  def user_channel_url(user)
    "#{root_url}#{user.name}"
  end

  def user_avatar_url(user)
    if user.present?
      if user.avatar_url(:thumb).present?
        user.avatar_url(:thumb).to_s
      else
        "default_user.jpg"
      end
    else
        "default_user.jpg"
    end
  end

  def video_poster_url(post)
    if post.video_url(:poster).present?
      post.video_url(:poster).to_s
    else
      "default_poster.jpg"
    end
  end

  def video_source_url(post)
    post.video_url.to_s
    #post.video_url(:mp4).to_s
    #post.video_url(:ogv).to_s
  end
end
