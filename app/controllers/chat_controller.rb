class ChatController < ApplicationController

  def index
    @groups = current_user.groups
    @group = Group.new
  end
end
