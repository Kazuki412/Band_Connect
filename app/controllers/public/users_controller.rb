class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: %i[update destroy]

  def index
    @users = User.includes(:musical_instrument).all
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
    @posts = @user.posts.order("id DESC").limit(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "変更を保存しました"
    redirect_to public_user_path(@user)
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
      redirect_to root_path, alert: "ゲストユーザーの更新・退会はロックしています"
    end
  end

end
