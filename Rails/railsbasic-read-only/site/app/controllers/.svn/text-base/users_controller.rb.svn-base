class UsersController < ApplicationController

before_filter :authenticate_admin!, :only => [:index]
before_filter :authenticate_user!, :only => [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /username
  def post
    @user = User.find_by_username(params[:username])

    guide_select = "Answers"
    if params[:guide_select].present?
      guide_select = params[:guide_select]
    end
    if guide_select == "Questions"
      # .where(:user_id => @user)
      @posts = Question.where("removed_at IS NULL").page(params[:page]).per(8)
    elsif guide_select == "Evaluations"
      # .where(:user_id => @user)
      @posts = Evaluation.where("removed_at IS NULL").page(params[:page]).per(8)
    #elsif guide_select == "Speeches"
    #  @posts = Speech.where("removed_at IS NULL").where(:user_id => @user).page(params[:page]).per(8)
    #elsif guide_select == "Sidenotes"
    #  @posts = Sidenote.where("removed_at IS NULL").where(:user_id => @user).page(params[:page]).per(8)
    else
      # .where(:user_id => @user)
      @posts = Answer.where("removed_at IS NULL").page(params[:page]).per(8)
    end

    if request.xhr?
      if params[:page].present?
        sleep(1)
        render :partial => "users/"+guide_select.downcase
      end
    end
  end



end
