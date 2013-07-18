class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :beta_authenticate

protected
  def beta_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "betauser" && password == "test668899"
    end
  end
  
end
