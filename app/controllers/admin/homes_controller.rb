class Admin::HomesController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def top #Topページに最近投稿された内容を表示するため
    @users = User.page(params[:page]).per(7)
  end
  
end
