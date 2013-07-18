module ApplicationHelper
  def user_profile_url(user)
    "#{root_url}#{user.username}"
  end

  def user_avatar_url(user, size = 96)
    if user.present?
      if user.avatar.present?
        user.avatar_url.to_s
      else
        # This is for test only
        "#{root_url}assets/user/avatar/#{user.id}/#{user.id}.jpg"
      end
    else
        # "default_user.png"
        "default_user.png"
    end
  end

  def post_voice_url(post)
    if post.voice?
      post.voice_url.to_s
    else
      default_url = "#{root_url}assets/user/voice/"+post.user_id.to_s+'/'+post.id.to_s
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
