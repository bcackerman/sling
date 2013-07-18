class SpeechesController < ApplicationController
  before_filter :admin_required, except: %w(show view)
  respond_to :html #:json

  def index
    @speeches = Speech.all
  end

  def show
    @speech = Speech.find(params[:id])
  end

  def view
    @played = Speech.find(params[:id])
    @played.increment!(:views)
    render :nothing => true
  end

  def new
    @speech = Speech.new
  end

  def edit
    @speech = Speech.find(params[:id])
  end

  def create
    @speech = Speech.new(params[:speech])

    if @speech.save
      redirect_to @speech, notice: 'Speech was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @speech = Speech.find(params[:id])

    if @speech.update_attributes(params[:speech])
      redirect_to @speech, notice: 'Speech was successfully updated.'
    else
      render action: "edit"
    end

  end

end
