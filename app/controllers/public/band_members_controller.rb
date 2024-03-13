class Public::BandMembersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @band = Band.find(params[:band_id])
    @band_permit = BandPermit.find(params[:band_permit_id])
    @band_member = BandMember.create(user_id: @band_permit.user_id, band_id: params[:band_id])
    @band_permit.destroy
    flash[:notice] = "バンドに参加しました"
    redirect_to request.referer
  end

  def destroy
    band_member = current_user.band_members.find_by(band_id: params[:band_id])
    band_member.destroy
    flash[:alert] = "バンドを脱退しました"
    redirect_to request.referer
  end
  
end
