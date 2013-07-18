class PostsController < ApplicationController
  include RatingsHelper
  before_filter :authenticate_user!, except: %w(home featured index channel show view)
  respond_to :html,:js

  def home
    render :layout => "frontpage"
  end

  def featured
    @popover = Speech.find_by_id(params[:pop_select])
  end

  def view
    @played = Post.find(params[:id])
    @played.increment!(:views)
    render :nothing => true
  end

  def upload
    @post = Post.new
    @category = params[:cat_select]
    if @category == nil
      @category = "Speech"
    end
    if @category == "Speech"
      @relative = Post.show.where(:user_id => current_user.id).where(:category => @category).order("created_at DESC").first
    elsif @category == "Evaluation"
      @relative = Post.find_by_id(params[:link_id])
      @post.ratings.build(:user_id => current_user.id)
    elsif @category == "Answer"
      @relative = Question.find_by_id(params[:link_id])
    end
  end
  
  def index
    @featured = Speech.show.desc.limit(90)
    session[:tab_select] = params[:tab_select] if params[:tab_select].present?
    session[:cat_filter] = params[:cat_filter] if params[:cat_filter].present?

    if session[:tab_select] == "Newest"
      query_order = "created_at DESC"
    elsif session[:tab_select] == "Most Viewed"
      query_order = "views DESC"
    elsif session[:tab_select] == "Most Liked"
      query_order = "likes_count DESC"
    else
      query_order = "created_at DESC"
    end

    if user_signed_in?
      privacy_set = ["Public", "Members"]
    else
      privacy_set = "Public"
    end
    
    if session[:cat_filter].blank? or session[:cat_filter] == "All"
      if session[:tab_select] == "Most Liked"
        @posts = @posts_result.show.where(:privacy => privacy_set).like.order(query_order).page(params[:page]).per(12)
      else
        @posts = @posts_result.show.where(:privacy => privacy_set).order(query_order).page(params[:page]).per(12)
      end
    else
      if session[:tab_select] == "Most Liked"
        @posts = @posts_result.show.where(:privacy => privacy_set).where(:category => session[:cat_filter]).like.order(query_order).page(params[:page]).per(12)
      else
        @posts = @posts_result.show.where(:privacy => privacy_set).where(:category => session[:cat_filter]).order(query_order).page(params[:page]).per(12)
      end
    end
  end

  def channel
    @watch = "Channel"
    session[:user_name] = params[:username] if params[:username].present?
    @post_user = User.find_by_name(session[:user_name])

    if user_signed_in?
      if current_user == @post_user
        privacy_set = ["Public", "Members", "Private"]
      else
        privacy_set = ["Public", "Members"]
      end
    else
      privacy_set = "Public"
    end

    if user_signed_in? and current_user == @post_user
      @post_process = Post.where(:user_id => @post_user.id).where(:success => true).last
      if @post_process.present? and @post_process.processed == true
        @post_process = nil
      end
    end

    @posts_show = @posts_result.where(:user_id => @post_user.id).show
    session[:cat_filter] = params[:cat_filter] if params[:cat_filter].present?
    if session[:cat_filter].blank? or session[:cat_filter] == "All"
      @posts = @posts_show.where(:privacy => privacy_set).desc.page(params[:page]).per(4)
    else
      @posts = @posts_show.where(:privacy => privacy_set).desc.where(:category => session[:cat_filter]).page(params[:page]).per(4)
    end
    create_metric_bar(@posts.first)

    @total_count = @posts_show.count
    @speech_count = @posts_show.where(:category => "Speech").count
    @eval_count = @posts_show.where(:category => "Evaluation").count
    @answer_count = @posts_show.where(:category => "Answer").count
    @question_count = Question.where(:user_id => @post_user.id).count
    
    @best_speech = @posts_show.where(:category => "Speech").like.order("likes_count DESC").first
    @best_eval = @posts_show.where(:category => "Evaluation").like.order("likes_count DESC").first
    @best_answer = @posts_show.where(:category => "Answer").like.order("likes_count DESC").first
    @best_question = Question.where(:user_id => @post_user.id).answer.order("answers_count DESC").first
  end

  def show
    @watch = "Show"
    @post = Post.find(params[:id])
    if @post.category == "Speech"
      @posts_show = @posts_result.where(:speech_id => @post.id).show
      @posts = @posts_show.desc.page(params[:page]).per(4)
      if @posts_show.present?
        @best = @posts_show.like.order("likes_count DESC").first
        create_metric_bar(@best)
      end
    end
    create_metric_column(@post)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      session[:upload_id] = @post.id
      render :nothing => true
    else
      flash[:alert] = "Sorry, something went wrong. Please try upload again."
      render :js => "window.location.replace('#{post_channel_path(@post.user.name)}')"
    end
  end

  def save
    @post = Post.find(session[:upload_id])
    @post.update_attributes(params[:post])
    redirect_to post_channel_path(@post.user.name)
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    respond_to do |format|
      format.html { redirect_to post_channel_path(@post.user.name) }
      format.js { }
    end
  end

end

