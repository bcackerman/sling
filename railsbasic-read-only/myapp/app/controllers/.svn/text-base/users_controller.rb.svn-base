class UsersController < ApplicationController

before_filter :authenticate_admin!, :only => [:index]

  def index
    @search = User.search(params[:search])
    @users = @search.order("id").page(params[:page]).per(20)
  end
 
  def show
    @user = User.find_by_username(params[:username])
    @flt_post = Post.where(:user_id => @user.id).search(params[:search])
    @post = @flt_post.order(:created_at.desc).page(params[:page]).per(8)
  end

  def edit
    @user = User.find_by_username(params[:username])
    @friends = @user.friendships.order(:created_at.desc).collect {|f| f.friend}
  end

  def update
    @user = User.find_by_username(params[:username])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user profile."
      redirect_to show_user_profile_path
    else
      render :action => 'edit'
    end

  end

  def friend
    @user = User.find_by_username(params[:username])
  end

end
