class MessagesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    logger.info(params[:group_id])
    @messages = Message.where(group_id: params[:group_id]).order('created_at DESC')
    respond_to do|format|
      format.js
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id
    @message.save!
    respond_to do|format|
      format.html
      format.js
    end

  end
end
