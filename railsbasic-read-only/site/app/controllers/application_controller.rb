class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :beta_authenticate
  before_filter :load_featured_answers

  def load_featured_answers
    @featured = Answer.where("removed_at IS NULL").order("created_at ASC") #.where("featured IS NOT NULL")
  end

protected
  def beta_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "betauser" && password == "test"
    end
  end
  
end
