class PostsController < ApplicationController

  def home
    render :layout => "frontpage"
  end

  def featured
    @popover = Post.find_by_id(params[:pop_select])
  end

  def upload
    @post = Post.new
  end

  def worker
    session[:video_url] = params[:video_url]
    VideoWorker.convert()
    render :nothing => true
  end
  
  def player
    @post_play = Post.find(params[:vid_select])
  end

  def index
    @featured = Post.show.desc.limit(90)
    session[:tab_select] = params[:tab_select] if params[:tab_select].present?
    session[:cat_filter] = params[:cat_filter] if params[:cat_filter].present?
    session[:ski_filter] = params[:ski_filter] if params[:ski_filter].present?

    if session[:tab_select] == "Newest Videos"
      query_order = "created_at DESC"
    elsif session[:tab_select] == "Most Viewed"
      query_order = "views DESC"
    elsif session[:tab_select] == "Most Liked"
      query_order = "likes DESC"
    else
      query_order = "created_at DESC"
    end
    
    if session[:cat_filter].blank? or session[:cat_filter] == "All"
      @posts = @posts_result.show.order(query_order).page(params[:page]).per(12)
    elsif session[:ski_filter] == "All"
      @posts = @posts_result.show.where(:category_id => session[:cat_filter]).order(query_order).page(params[:page]).per(12)
    else
      @posts = @posts_result.show.where(:category_id => session[:cat_filter]).where(:skill_id => session[:ski_filter]).order(query_order).page(params[:page]).per(12)
    end
  end

  def channel
    session[:user_name] = params[:username] if params[:username].present?
    @post_user = User.find_by_name(session[:user_name])

    session[:cat_filter] = params[:cat_filter] if params[:cat_filter].present?
    session[:ski_filter] = params[:ski_filter] if params[:ski_filter].present?
    if session[:cat_filter].blank? or session[:cat_filter] == "All"
      @posts = @posts_result.show.desc.where(:user_id => @post_user.id).page(params[:page]).per(8)
    elsif session[:ski_filter] == "All"
      @posts = @posts_result.show.desc.where(:user_id => @post_user.id).where(:category_id => session[:cat_filter]).page(params[:page]).per(8)
    else
      @posts = @posts_result.show.desc.where(:user_id => @post_user.id).where(:category_id => session[:cat_filter]).where(:skill_id => session[:ski_filter]).page(params[:page]).per(8)
    end
    
  end

  def show
    @post = Post.find(params[:id])
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
    @post.save
    #    redirect_to @post, notice: 'Post was successfully created.'
    #else
    #end
    session[:upload_id] = @post.id
    render :nothing => true
  end

  def save
    @post = Post.find(session[:upload_id])
    @post.update_attributes(params[:post])
    redirect_to @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      format.json { head :no_content }
    else
      format.html { render action: "edit" }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end

