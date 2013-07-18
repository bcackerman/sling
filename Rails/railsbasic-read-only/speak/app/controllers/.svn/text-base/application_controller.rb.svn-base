class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :beta_authenticate
  before_filter :reset_filter_tab
  before_filter :preload_filter_search

  #layout :determine_layout
  #rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to root_path, :alert => exception.message
  #end

  def after_sign_in_path_for(resource)
    post_channel_path(current_user.name)
  end

  def reset_filter_tab
    if request.xhr?
      session[:tab_select] ||= "Newest Posts"
      session[:cat_filter] ||= "All"
    else
      session[:tab_select] = "Newest Posts"
      session[:cat_filter] = "All"
    end
  end

  def preload_filter_search
    @posts_search = Post.search(params[:q])
    @posts_result = @posts_search.result
    @questions_search = Question.search(params[:q])
    @questions_result = @questions_search.result
    @groups_search = Group.search(params[:q])
    @groups_result = @groups_search.result
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

  def admin_required
    unless current_user && current_user.is_admin?
      flash[:error] = "Sorry, you don't have access to that page!"
      redirect_to root_url and return false
    end
  end


end
