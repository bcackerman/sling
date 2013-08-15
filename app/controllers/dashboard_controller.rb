class DashboardController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json, only: [:index]

  def index
    @clips = current_user.clips.order("created_at DESC")
    respond_with @clips
  end
end
