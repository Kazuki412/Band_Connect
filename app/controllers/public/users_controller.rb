class Public::UsersController < ApplicationController

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
    redirect_to public_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :musical_instrument_id, :motivation_id, :introduction)
  end

end
