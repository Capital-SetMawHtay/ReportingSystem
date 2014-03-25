module ApplicationHelper

  def message_presenter(message)
    if(message.user == current_user) then
      render partial: 'messages/own_message',locals: {message: message}
    else
      render partial: 'messages/other_message',locals: {message: message}
    end

  end
end
