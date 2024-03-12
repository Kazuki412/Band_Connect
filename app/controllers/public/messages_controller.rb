class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    if message.save
      redirect_to public_dm_room_path(message.dm_room)
    else 
      redirect_to request.referer
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:dm_room_id, :content)
  end
  
end
