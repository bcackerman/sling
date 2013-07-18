class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:create, :new, :reply]
  before_filter :is_post_owner, :only => [:remove]

  def index
    mode = params[:mode]
    search = params[:search]

    @post = Post.where("removed_at IS NULL").search(search)

    if mode == "Search" # Search Questions
      @question = @post
      #@answer = 
    else # Top Rated Answers
      @answer = @post.order(:voice_played.desc, :created_at.desc).page(params[:page]).per(8)
    end
  end

  def played
    @post = Post.find(params[:id])
    @post.increment!(:voice_played)
    render :nothing => true
  end

  def topic
    mode = params[:mode]
    @topic = Post.where("removed_at IS NULL").find(params[:id])
    @post = Post.where("removed_at IS NULL").where(:topic_id => params[:id]).order(:voice_played.desc).page(params[:page]).per(8)
    if request.xhr?
      if params[:page].present?
        sleep(1)
        render :partial => "shared/post"
      end
    end
  end

  def show
    @post = Post.where("removed_at IS NULL").find(params[:id])
  end

  def new
    @topic = nil
    @post = Post.new
    @user = current_user
  end

  def reply
    @topic = Post.find(params[:id])
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.topic_id.blank?
      @post.is_topic = true
    end

    tempfile = 'foo_' + rand(65536).to_s

    if params[:record_file].present?
      if valid_wav_file(params[:record_file])
        Post.convert_user_voice(params[:record_file], @post.user_id.to_s, tempfile)
        if @post.save
          Post.save_user_voice(@post.user_id.to_s, @post.id.to_s, tempfile)
          if @post.is_topic
            flash[:notice] = "Successfully created a new topic."
          else  
            flash[:notice] = "Successfully created a new echo."
          end
          render :json => "{\"saved\":1}"
        else
          if @post.is_topic
            flash[:alert] = "Could not create topic, try again later."
          else
            flash[:alert] = "Could not create echo, try again later."
          end
        end
      else
        flash[:alert] = "Could not create topic or echo, invalid audio format."
        render :json => "{\"saved\":0}"
      end
    end
  end

  def remove
    @post = Post.find(params[:id])
    if @post.is_topic
      replies = Post.where("removed_at IS NULL").where(:topic_id => @post.id)
      if replies.present?
        flash[:alert] = "This topic has echoes and can not be removed."
        redirect_to user_post_profile_path(current_user.username)
        return
      end
    end

    if @post.update_attribute(:removed_at, Time.now.utc)
      if @post.is_topic
        flash[:notice] = "Successfully removed a post topic."
      else
        flash[:notice] = "Successfully removed a post echo."
      end
    else
      flash[:alert] = "Could not remove post, try again later."
    end
    redirect_to user_post_profile_path(current_user.username)
  end

  private
  def is_post_owner 
    @post = Post.find(params[:id])
    unless user_signed_in? && @post.user == current_user
      redirect_to(root_url, :notice => 'You cannot edit a post that you did not create.')
    end
  end

  def valid_wav_file(record_file)
    ufile = record_file['filename']
    udata = File.open(ufile.path, 'rb')
    type = ufile.content_type
    header = udata.read(4)
    chunk_size = udata.read(4).unpack('V').join.to_i
    format = udata.read(4)
    return type == 'audio/x-wav' && header == 'RIFF' && format == 'WAVE' && chunk_size == (ufile.size-8)
  end
end
