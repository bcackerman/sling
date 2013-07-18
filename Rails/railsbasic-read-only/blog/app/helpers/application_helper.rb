module ApplicationHelper
  def user_profile_url(user)
    "#{root_url}#{user.username}"
  end

  def user_friend_url(user)
    "#{root_url}#{user.username}/friend"
  end

  def user_avatar_url(user, size = 96)
    if user.avatar.present?
      user.avatar_url.to_s
    else
      "#{root_url}images/guest.png"
    end
  end

  def gravatar_token(user)
      if user.gravatar.present?
        Digest::MD5.hexdigest(user.gravatar.downcase)
      elsif user.email.present?
        Digest::MD5.hexdigest(user.email.downcase)
      end
  end

  def post_voice_url(post)
    if post.voice.present?
      post.voice_url.to_s
    else
      default_url = "#{root_url}assets/user/voice/"+post.user_id.to_s+'/'+post.id.to_s
    end
  end

  def gnews_voice_url(gnews)
    if gnews.voice.present?
      gnews.voice_url.to_s
    else
      default_url = "#{root_url}assets/news/voice/"+gnews.topic_date.strftime("%Y-%m-%d")+'/'+gnews.id.to_s
    end
  end

  def pageless(div, total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => 'Loading more echoes'
    }
    container && opts[:container] ||= container
    javascript_tag("$('#{div}').pageless(#{opts.to_json});")
  end 
end
