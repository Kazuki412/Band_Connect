class Public::BandPermitsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @band = Band.find(params[:group_id])
    band_permit = current_user.band_permits.new(group_id: params[:group_id])
    band_permit.save
    redirect_to request.referer, notice: "バンドへの参加申請をしました"
  end 
  
  def destroy
    band_permit = current_user.band_permits.find_by(group_id: params[:group_id])
    band_permit.destroy
    redirect_to request.referer, alert: "バンドへの参加申請を取り消しました。"
  end 
  
end
