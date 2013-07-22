class LikesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js
  
  def create
    @like = Like.create(params[:like])
    @post = @like.post
    render :toggle
  end

  def destroy
    like = Like.find(params[:id]).destroy
    @post = like.post
    render :toggle
  end

end

