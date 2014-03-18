class ChatController < ApplicationController

  def index
    @groups = current_user.groups
    @owned_groups = current_user.owned_groups
    @group = Group.new
  end
end
