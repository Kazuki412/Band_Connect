class Public::DmRoomsController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_band_member
  
  def create
    @dm_room = DmRoom.create
    @current_entry = Entry.create(dm_room_id: @dm_room.id, user_id: current_user.id)
    @another_entry = Entry.create(params.require(:entry).permit(:user_id, :dm_room_id).merge(dm_room_id: @dm_room.id))
    redirect_to public_dm_room_path(@dm_room)
  end

  def new
    @users = User.all
    @current_dm_room = DmRoom.find(params[:id])
    @entry = Entry.new
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

  def room_add_user
    entry = Entry.new(entry_params)
    if entry.save
      redirect_to public_dm_room_path(entry.dm_room_id)
    else
      redirect_to public_new_dm_room_path(entry.dm_room_id)
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :dm_room_id)
  end
  
  # def ensure_band_member
  #   dm_room = DmRoom.find(params[:id])
  #   user = dm_room.entries.where.not(user_id: current_user.id).first.user
  #   if current_user.bands.exists?
  #     unless current_user.bands.pluck(:band_id) == user.bands.pluck(:band_id)
  #       redirect_to public_bands_path, alert: "バンドメンバーでなければDMできません"
  #     end 
  #   else
  #     redirect_to public_bands_path, alert: "バンドに参加していなければDMできません"
  #   end 
  # end
end
