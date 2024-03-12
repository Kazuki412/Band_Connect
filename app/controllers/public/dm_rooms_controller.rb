class Public::DmRoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @dm_room = DmRoom.create
    @current_entry = Entry.create(dm_room_id: @dm_room.id, user_id: current_user.id)
    @another_entry = Entry.create(params.require(:entry).permit(:user_id, :dm_room_id).merge(dm_room_id: @dm_room.id))
    redirect_to public_dm_room_path(@dm_room)
  end
  
  def index
    current_entries = current_user.entries
    my_dm_room_id = []
    current_entries.each do |entry|
      my_dm_room_id << entry.dm_room.id
    end 
    @another_entries = Entry.where(dm_room_id: my_dm_room_id).where.not(user_id: current_user.id)
  end 

  def show
    @dm_room = DmRoom.find(params[:id])
    @messages = @dm_room.messages.all
    @message = Message.new
    @entries = @dm_room.entries
  end
end
