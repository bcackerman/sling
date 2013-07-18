class FeedbacksController < ApplicationController

before_filter :authenticate_admin!, :only => [:index]

  def index
    @search = Feedback.search(params[:search])
    @feedbacks = @search.order(:id.desc).page(params[:page]).per(20)
  end

  def new
    @feedback = Feedback.new
    if current_user
      @feedback.name = current_user.username
      @feedback.email = current_user.email
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      redirect_to root_url, :notice => "Your feedback is valuable to us. Thank you!"
    else
      render :new
    end
  end
  
end
