class GroupsController < ApplicationController

  def index
    @groups = Group.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def create
    @user = User.find(params[:user_id])
    @group = Group.new(params[:group])
    @group.owner_id = current_user.id
    @group.save!
    @group.subscriptions.create(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end
  def update
    @group = Group.find(params[:id])
    @group.update_attributes(params[:group])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
