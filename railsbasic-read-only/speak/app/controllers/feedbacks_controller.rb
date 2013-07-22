class FeedbacksController < ApplicationController
  before_filter :admin_required, except: %w(new create)
  respond_to :html

  def index
    @feedbacks = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if user_signed_in?
      @feedback.user = current_user
    end
    if @feedback.save
      redirect_to root_path
    else
      render action: "new"
    end
  end

  def update
    @feedback = Feedback.find(params[:id])

    if @feedback.update_attributes(params[:feedback])
      redirect_to @feedback, notice: 'Feedback was successfully updated.'
    else
      render action: "edit"
    end
  end

end
