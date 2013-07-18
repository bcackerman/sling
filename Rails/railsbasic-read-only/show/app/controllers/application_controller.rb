class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :beta_authenticate
  before_filter :reset_filter_tab
  before_filter :preload_filter_group
  before_filter :preload_posts_search

  #layout :determine_layout
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    root_path + current_user.name
  end

  def reset_filter_tab
    if request.xhr?
      session[:tab_select] ||= "Newest Videos"
      session[:cat_filter] ||= "All"
    else
      session[:tab_select] = "Newest Videos"
      session[:cat_filter] = "All"
    end
  end
  
  def preload_filter_group
    @post_category = Category.order(:name)
  end

  def preload_posts_search
    @search = Post.search(params[:q])
    @posts_result = @search.result
  end

private
  def determine_layout
    current_user ? "private" : "public"
  end

protected
  def beta_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "betauser" && password == "test"
    end
  end

end
