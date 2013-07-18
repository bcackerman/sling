class UsersController < ApplicationController

before_filter :authenticate_admin!, :only => [:index]
before_filter :authenticate_user!, :only => [:edit, :update]

  def index
    @search = User.search(params[:search])
    @users = @search.order(:id.desc).page(params[:page]).per(50)
  end
 
  def post
    @user = User.find_by_username(params[:username])
    @post = Post.where("removed_at IS NULL").where(:user_id => @user).order(:created_at.desc).page(params[:page]).per(8)
    if current_user.present?
      @friendship = current_user.friendships.find_by_friend_id(@user)
      if @friendship.present?
        @friendship.update_attribute(:visited_at, Time.now)
      end
    end
    if request.xhr?
      if params[:page].present?
        sleep(1)
        render :partial => "shared/post"
      end
    end
  end

  def edit
    @user = User.find_by_username(params[:username])
  end

  def update
    @user = User.find_by_username(params[:username])
    if params[:user][:avatar].present?
      @user.avatar = params[:user][:avatar]
      if @user.avatar_integrity_error
        flash[:alert] = "Changes could not be saved (not an allowed file type)"
      elsif @user.avatar.size > 100.kilobytes
        flash[:alert] = "Avatar file is too big (should be at most 100K bytes)"
      else
        if @user.update_attribute(:is_avatar, true)
          if @user.update_attribute(:avatar, @user.avatar)
            flash[:notice] = "Successfully uploaded user avatar."
          else
            flash[:alert] = "Sorry, could not upload avatar image."
          end
        else
          flash[:alert] = "Sorry, could not upload avatar image."
        end
      end
    elsif params[:user][:gravatar].present?
      if @user.update_attribute(:is_avatar, false)
        if @user.update_attribute(:gravatar, params[:user][:gravatar])
          flash[:notice] = "Successfully updated gravatar link."
        else
          flash[:alert] = "Sorry, could not update gravatar."
        end
      else
        flash[:alert] = "Sorry, could not update gravatar."
      end
    else
        flash[:alert] = "Nothing to update or upload."
    end
    redirect_to user_post_profile_path
  end

  def friend
    @user = User.find_by_username(params[:username])
    @friendship = @user.friendships.page(params[:page]).per(16)
  end
end
