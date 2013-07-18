class FriendshipsController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :destroy]

  def create
    @friendship = current_user.friendships.find_by_friend_id(params[:friend_id])
    if @friendship.present?
      @friendship.update_attribute(:refreshed_at, Time.now)
      redirect_to root_url+current_user.username, :notice => "Successfully refreshed friendship."
    else
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        redirect_to root_url+current_user.username, :notice => "Successfully added friend."
      else
        redirect_to root_url+current_user.username, :alert => "Sorry, unable to add friend."
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to root_url+current_user.username, :notice => "Successfully removed friendship."
  end
end
