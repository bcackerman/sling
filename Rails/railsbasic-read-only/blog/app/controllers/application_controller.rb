class ApplicationController < ActionController::Base
  before_filter :beta_authenticate
  protect_from_forgery
  before_filter :set_time_zone, :load_gnews_init

  def set_time_zone
    min = cookies[:timezone].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
  end

  def load_gnews_init
    if session[:gnews_start]
      @gnews_top = Gnews.where("removed_at IS NULL").where("published_at IS NOT NULL").where("topic_id IS NOT NULL").order(:topic_id.desc).limit(12)
      @gnews_right = @gnews_top[session[:gnews_index]]
      @gnews_left = Gnews.find(@gnews_right.topic_id)
    else
      session[:gnews_start] = 1
      session[:gnews_index] = 0
      @gnews_right = Gnews.where("removed_at IS NULL").where("published_at IS NOT NULL").where("topic_id IS NOT NULL").last
      @gnews_left = Gnews.find(@gnews_right.topic_id)
    end
  end

protected
  def beta_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "betauser" && password == "test"
    end
  end
  
end
