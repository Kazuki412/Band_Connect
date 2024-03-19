class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("id DESC").page(params[:page]).per(8)
  end

  def update #素行の悪いユーザーをブロックするため、解除も可能
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "ユーザー情報を更新しました"
    redirect_to admin_path
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end

end
