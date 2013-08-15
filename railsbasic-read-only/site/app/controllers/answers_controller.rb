class AnswersController < ApplicationController



  def index
    tab_select = params[:tab_select]
    if tab_select == "Listened"
      query_order = "listened DESC"
    elsif tab_select == "Newest"
      query_order = "created_at DESC"
    elsif tab_select == "Popular"
      query_order = "liked DESC"
    else
    end
    @answers = Answer.where("removed_at IS NULL").order(query_order).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
      format.js
    end
  end

  def featured
    @popup = Answer.find_by_id(params[:pop_select])
  end


  def new
    @answer = Answer.new

    respond_to do |format|
      format.html { render :layout => false } # new.html.erb
      format.json { render json: @question }
    end

  end

  def create
    @answer = Answer.new(params[:answer])
    #@answer.user = current_user
@answer.user = User.find(11)

    tempfile = 'foo_' + rand(65536).to_s

    if params[:record_file].present?
      if valid_wav_file(params[:record_file])
        Answer.convert_user_voice(params[:record_file], @answer.user_id.to_s, tempfile)
        if @answer.save
          #Answer.save_user_voice(@answer.user_id.to_s, @answer.id.to_s, tempfile)
          Answer.save_user_voice(@answer.user_id.to_s, '3', tempfile)
          render :json => "{\"saved\":1}"
        end
      else
        render :json => "{\"saved\":0}"
      end
    end

  end

  def played
    @answer = Answer.find(params[:id])
    @answer.increment!(:played)
    render :nothing => true
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
