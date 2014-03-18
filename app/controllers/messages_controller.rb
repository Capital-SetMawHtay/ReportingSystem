class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    @message.save!
    respond_to do|format|
      format.html
      format.js
    end

  end
end
