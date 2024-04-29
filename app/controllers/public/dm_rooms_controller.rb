class Public::DmRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_band_member, except: [:index, :create, :destroy, :room_add_user]

  def create
    @dm_room = DmRoom.create
    @current_entry = Entry.create(dm_room_id: @dm_room.id, user_id: current_user.id)
    @another_entry = Entry.create(params.require(:entry).permit(:user_id, :dm_room_id).merge(dm_room_id: @dm_room.id))
    redirect_to dm_room_path(@dm_room.id)
  end

  def new
    @users = User.all
    @current_dm_room = DmRoom.find(params[:id])
    @entry = Entry.new
  end

  def index
    my_dm_room_id = []
    current_user.entries.each do |entry|
      my_dm_room_id << entry.dm_room.id
    end
    @my_dm_rooms = DmRoom.where(id: my_dm_room_id)
  end

  def show
    @dm_room = DmRoom.find(params[:id])
    @messages = @dm_room.messages.all
    @message = Message.new
    @entries = @dm_room.entries
  end

  def edit
    @dm_room = DmRoom.find(params[:id])
  end

  def update
    @dm_room = DmRoom.find(params[:id])
    if @dm_room.update(dm_room_params)
      flash[:notice] = "ルーム名を更新しました"
      redirect_to dm_room_path(@dm_room.id)
    else
      flash[:alert] = "ルーム名の更新に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    @dm_room = DmRoom.find(params[:id])
    @dm_room.destroy
    flash[:alert] = "トークルームを削除しました"
    redirect_to request.referer
  end

  def room_add_user
    entry = Entry.new(entry_params)
    if entry.save
      flash[:notice] = "トークメンバーを追加しました"
      redirect_to dm_room_path(entry.dm_room_id)
    else
      redirect_to new_dm_room_path(entry.dm_room_id)
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :dm_room_id)
  end

  def dm_room_params
    params.require(:dm_room).permit(:name)
  end

  def ensure_band_member
    dm_room = DmRoom.find(params[:id])
    entries = dm_room.entries.where.not(user_id: current_user.id)
    entry_users = entries.map{|entry| entry.user}
    results = entry_users.map do |user|
      current_user.bands.pluck(:band_id).any? {|band_id| user.bands.pluck(:band_id).include?(band_id)}
    end
    if current_user.bands.exists?
      unless results.all?{|result| result == true}
        redirect_to dm_rooms_path, alert: "バンドメンバーでなければDMできません"
      end
    else
      redirect_to request.referer, alert: "バンドに参加していなければDMできません"
    end
  end
end
