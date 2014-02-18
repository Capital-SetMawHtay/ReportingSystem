class UsersController < ApplicationController
  load_and_authorize_resource :user
  def index
      @users = User.non_admin
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if(@user.save!)
      redirect_to @user, notice: "User successfully created!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if@user.update_attributes!(params[:user])then
      redirect_to users_path,notice: "User successfully updated"
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
