class GnewsController < ApplicationController

  before_filter :authenticate_admin!, :only => [:manage, :create, :new, :reply, :publish, :remove]


  def top
    @gnews_top = Gnews.where("removed_at IS NULL").where("published_at IS NOT NULL").where("topic_id IS NOT NULL").order(:topic_id.desc).limit(12)
    session[:gnews_index] += 1
    if session[:gnews_index] >= @gnews_top.size || session[:gnews_index] >= 12
      session[:gnews_index] = 0
    end
    @gnews_right = @gnews_top[session[:gnews_index]]
    @gnews_left = Gnews.find(@gnews_right.topic_id)
  end

  def index
    mode = params[:mode]
    @gnews_reply = Gnews.where("removed_at IS NULL").where("published_at IS NOT NULL").where("topic_id IS NOT NULL").order(:topic_date.desc).page(params[:page]).per(4)
    end
    if request.xhr?
      if params[:page].present?
        sleep(1)
        render :partial => "front"
      end
    end
  end

  def manage
    @gnews_topic = Gnews.where("removed_at IS NULL").where("topic_id IS NULL").order(:topic_date.desc).page(params[:page]).per(4)
  end

  def new
    @topic = nil
    @gnews = Gnews.new
  end

  def show
    @gnews = Gnews.where("removed_at IS NULL").where("published_at IS NOT NULL").find(params[:id])
  end

  def played
    @gnews = Gnews.find(params[:id])
    @gnews.increment!(:voice_played)
    render :nothing => true
  end

  def reply
    @topic = Gnews.find(params[:id])
    @gnews = Gnews.new
  end

  def create
    @gnews = Gnews.new(params[:gnews])

    @gnews.topic_date = Time.now.utc
    dateid = @gnews.topic_date.strftime("%Y-%m-%d")
    tempfile = 'foo_' + rand(65536).to_s

    if params[:record_file].present?
      if valid_wav_file(params[:record_file])
        Gnews.convert_news_voice(params[:record_file], dateid, tempfile)  
        @gnews.save
        Gnews.save_news_voice(dateid, @gnews.id.to_s, tempfile)
        if @gnews.topic_id.blank?
          flash[:notice] = "Successfully created a news topic."
        else  
          flash[:notice] = "Successfully created a news echo."
        end
        render :json => "{\"saved\":1}"
      else
        flash[:alert] = "Could not create global news, try again later."
        render :json => "{\"saved\":0}"
      end
    else
      @gnews.save
      if @gnews.topic_id.blank?
        flash[:notice] = "Successfully created a news topic."
      else  
        flash[:notice] = "Successfully created a news echo."
      end
      redirect_to :action => 'manage'
    end
  end

  def publish
    @gnews = Gnews.find(params[:id])
    replies = Gnews.where("removed_at IS NULL").where(:topic_id => @gnews.id)
    if replies.blank?
      flash[:alert] = "This news has echoes and can not be removed."
      redirect_to :action => 'manage'
      return
    end
    if @gnews.update_attribute(:published_at, Time.now.utc)
      for reply in replies
        if !reply.update_attribute(:published_at, Time.now.utc)
          flash[:alert] = "Could not publish news, try again later."
          redirect_to :action => 'manage'
          return
        end
      end
      flash[:notice] = "Successfully published global news."
    else
      flash[:alert] = "Could not publish news, try again later."
    end
    redirect_to :action => 'manage'
  end

  def remove
    @gnews = Gnews.find(params[:id])
    if @gnews.topic_id.blank?
      replies = Gnews.where("removed_at IS NULL").where(:topic_id => @gnews.id)
      if replies.present?
        flash[:alert] = "This topic has replies and can not be removed."
        redirect_to :action => 'manage'
        return
      end
    end

    if @gnews.update_attribute(:removed_at, Time.now.utc)
      if @gnews.topic_id.blank?
        flash[:notice] = "Successfully removed a news topic."
      else
        flash[:notice] = "Successfully removed a news echo."
      end
    else
      flash[:alert] = "Could not remove news, try again later."
    end
    redirect_to :action => 'manage'
  end

  private
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
