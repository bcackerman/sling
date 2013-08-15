class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_required, except: %w(avatar update)
  respond_to :html, :json

  def index
    @users = User.all
  end

  def avatar
    @user = User.find(current_user)
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if params[:user][:avatar].present?
      render :crop
    elsif params[:user][:memo].present?
      respond_with @user
    else
      redirect_to post_channel_path(@user.name)
    end
  end
   
  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end

