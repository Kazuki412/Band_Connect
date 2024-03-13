class Public::BandPermitsController < ApplicationController
  before_action :authenticate_user!

  def create
    @band = Band.find(params[:band_id])
    band_permit = current_user.band_permits.new(band_id: params[:band_id])
    band_permit.save
    redirect_to request.referer, notice: "バンドへの参加申請をしました"
  end

  def destroy
    @band = Band.find(params[:band_id])
    band_permit = BandPermit.find_by(band_id: params[:band_id])
    band_permit.destroy
    redirect_to request.referer, alert: "バンドへの参加申請を取り消しました"
  end

end
