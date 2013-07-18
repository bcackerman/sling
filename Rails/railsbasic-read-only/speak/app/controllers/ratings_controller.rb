class RatingsController < ApplicationController
  include RatingsHelper
  before_filter :authenticate_user!, except: %w(metric)
  respond_to :html, :js
  
  def new
    @rating = Rating.new
    @post = Post.find_by_id(params[:link_id])
  end

  def create
    @rating = Rating.create(params[:rating])
    @post = @rating.post
    redirect_to post_path(@post)
  end

  def metric
    @metric = Post.find_by_id(params[:post_select])
    create_metric_bar(@metric)
  end

end

