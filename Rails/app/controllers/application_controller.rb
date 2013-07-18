class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "devise"
    else
      "application"
    end
  end

  def render_404
    respond_to do |type|
      type.html { render :template => "layouts/404", :layout => "application", :status => "404 Not Found" }
      type.all  { render :nothing  => true, :status => "404 Not Found" }
    end
  end
end
