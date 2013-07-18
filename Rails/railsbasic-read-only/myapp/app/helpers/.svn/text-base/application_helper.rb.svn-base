module ApplicationHelper
  def profile_url(user)
    "#{root_url}#{user.username}"
  end

  def friend_url(user)
    "#{root_url}#{user.username}/friend"
  end

  def avatar_url(user)
    if user.avatar?
      user.avatar_url.to_s
    else
      default_url = "#{root_url}images/guest.jpg"
      # for Gravatar only
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=96&d=#{CGI.escape(default_url)}"
    end
  end
 
  def voice_url(post)
    if post.voice?
      post.voice_url.to_s
    else
      default_url = "#{root_url}assets/user_voices/"+post.user_id.to_s+'/'+post.id.to_s+'.mp3'
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
