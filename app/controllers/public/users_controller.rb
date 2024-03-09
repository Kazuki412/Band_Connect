class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: %i[update destroy]

  def index
    @users = User.includes(:musical_instrument).all
  end

  def show
    @user = User.find(params[:id])
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
