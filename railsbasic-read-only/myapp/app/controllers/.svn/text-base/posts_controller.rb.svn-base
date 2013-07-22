class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :new, :reply]
  before_filter :is_post_owner, :only => [:edit, :update, :destory]

  def index
    lang_a = params[:lang_a]
    lang_b = params[:lang_b]
    search = params[:search]
    if lang_a || lang_b 
      @flt_post = Post.where(:language => [lang_a, lang_b]).search(search)
    else 
      @flt_post = Post.search(search)
    end
    @topic = @flt_post.order(:created_at.desc).page(params[:page]).per(8)
    @gnews = Post.where(:user_id => 2).order(:created_at).last
  end

  def topic
    @post = Post.where(:topic_id => params[:id]).page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = nil
    @post = Post.new
    @user = current_user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def reply
    @topic = Post.find(params[:id])
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.topic_id
      @post.is_reply = true
    end

    @post.save
    @post.reload
    if params[:record_file]
      Post.save_record_voice(params[:record_file], @post.user_id.to_s+'/'+@post.id.to_s)
    end

    if @post.is_reply
      flash[:notice] = "Successfully replied post."
    else  
      @post.update_attributes(:topic_id => @post.id)
      flash[:notice] = "Successfully created post."
    end
    redirect_to @post
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to posts_url
  end

  private
  def is_post_owner 
    @post = Post.find(params[:id])
    unless user_signed_in? && @post.user == current_user
      redirect_to(@post, :notice => 'You cannot edit a post that you did not create.')
    end
  end
end
