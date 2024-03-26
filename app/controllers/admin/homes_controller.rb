class Admin::HomesController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def top 
    @users = User.order("id DESC").page(params[:page]).per(7)
  end
  
end
