class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: %i[edit update destroy]
  before_action :ensure_login_user, only: [:edit, :update]

  def index
    @users = User.includes(:musical_instrument).order("id DESC").page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.dm_room_id == another.dm_room_id
            @is_room = true
            @dm_room_id = current.dm_room_id
          end
        end
      end
      unless @is_room
        @dm_room = DmRoom.new
        @entry = Entry.new
      end
    end
    @is_same_band_member = current_user.bands.pluck(:band_id).any? {|band_id| @user.bands.pluck(:band_id).include?(band_id)}
    @posts = @user.posts.order("id DESC").page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to public_user_path(@user)
    else
      flash[:alert] = "変更の保存に失敗しました"
      redirect_to request.referer
    end
  end

  def bookmarks
    @user = User.find(params[:id])
    bookmarks = Favorite.where(user_id: @user).pluck(:post_id)
    @bookmark_posts = Post.find(bookmarks)
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :musical_instrument_id, :motivation_id, :introduction)
  end

  def ensure_guest_user
    if current_user.email == "guest@guest"
      redirect_to root_path, alert: "ゲストユーザーの編集・更新はロックしています"
    end
  end
  
  def ensure_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to public_users_path, alert: '他ユーザーの編集はできません'
    end 
  end
    
end
