class UsersController < ApplicationController
 authorize_resource :user
  def index
      @active_team = params[:active_team] || 'all'
      if @active_team == 'all' then
        @users = User.non_admin
      else
        @users = User.non_admin.by_team(@active_team)
      end
      @users = @users.paginate(:page=>params[:page],:per_page=>5)
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if(@user.save)
      redirect_to @user, notice: "User successfully created!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do|format|
      format.html do
        if@user.update_attributes(params[:user])then
          redirect_to users_path(active_team: @user.team.name),notice: "User successfully updated"
        else
          render 'edit'
        end
      end
      format.js do
        if @user.update_attributes!(params[:user]) then
          render 'update',format: :js
        else
          render text: 'Update Error',notice: "@user.errors"
        end
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
