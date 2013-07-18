module ApplicationHelper
  if Rails.env.development?
    MyCloudPath = "http://mpztestwebcom.s3.amazonaws.com/"
  else
    MyCloudPath = "http://speakmirrorcom.s3.amazonaws.com/"
  end
  
  def site_name_no_space
    "SpeakMirror"
  end

  def site_name_with_space
    "Speak Mirror"
  end 

  def is_owner? user
    user_signed_in? and current_user == user
  end

  def user_channel_url(user, type)
    "#{root_url}#{user.name}"+"/"+type
  end

  def user_avatar_url(user)
    if user.present?
      if user.avatar_cloud.present?
        MyCloudPath + user.avatar_cloud
      elsif user.avatar_url(:thumb).present?
        user.avatar_url(:thumb).to_s
      else
        "default_user.jpg"
      end
    else
        "default_user.jpg"
    end
  end

  def speech_video_url(speech)
    MyCloudPath + speech.video_url
  end

  def speech_poster_url(speech)
    MyCloudPath + speech.poster_url
  end

  def speaker_avatar_url(speech)
    MyCloudPath + speech.avatar_url
  end

  def post_poster_url(post)
    if post.poster_cloud.present?
      MyCloudPath + post.poster_cloud
    elsif post.video_url(:poster).present?
      post.video_url(:poster).to_s
    else
      "default_poster.jpg"
    end
  end

  def post_video_url(post)
    if post.video_cloud.present?
      MyCloudPath + post.video_cloud
    elsif post.video_url(:mp4).present?
      post.video_url(:mp4).to_s
    else

    end
  end

  def post_subject_value(post)
    if post.category=="Speech"
      if post.objective.present?
        '- ' + post.objective.name
      end
    elsif post.category=="Evaluation"
      speech = Post.find(post.speech_id)
      if speech.objective.present?
        '- ' + speech.objective.name
      end
    elsif post.category=="Answer"
      question = Question.find(post.question_id)
      if question.subject.present?
        '- ' + question.subject.name
      end
    else
    end
  end

end
