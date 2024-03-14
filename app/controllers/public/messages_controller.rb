class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
    else
      flash[:alert] = "メッセージの送信に失敗しました"
      redirect_to request.referer
    end
    # 非同期で送信した内容追加し、トークの全体を表示する
    @dm_room = @message.dm_room
    @messages = @dm_room.messages.all
  end

  private

  def message_params
    params.require(:message).permit(:dm_room_id, :content)
  end

end
