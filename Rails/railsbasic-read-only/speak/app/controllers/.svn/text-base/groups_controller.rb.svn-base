class GroupsController < ApplicationController
  before_filter :admin_required
  #before_filter :authenticate_user!, except: %w(index channel show)

  def index
    session[:tab_select] = params[:tab_select] if params[:tab_select].present?
    if session[:tab_select] == "Newest"
      query_order = "created_at DESC"
    elsif session[:tab_select] == "Most Visited"
      query_order = "views DESC"
    elsif session[:tab_select] == "Most Liked"
      query_order = "likes DESC"
    else
      query_order = "created_at DESC"
    end

    @groups = @groups_result.order(query_order).page(params[:page]).per(12)

  end

  def channel
  
  end

  def show
    @group = Group.find(params[:id])

  end


  def new
    @group = Group.new

  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
