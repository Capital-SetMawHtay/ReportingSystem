class SubscriptionsController < ApplicationController

  def update
    @group = Group.find(params[:id])
    @users = User.find(params[:user_ids])
    @users.each do|u|
      @group.users<<u unless @group.users.exists?(u)
    end
    respond_to do |format|
      format.html do
        redirect_to '/chat',notice: 'You have edited user list for the group'
      end
      format.js
    end
  end
end
