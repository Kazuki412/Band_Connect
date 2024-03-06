class Public::BandMembersController < ApplicationController
  
  def create
    band_member = current_user.band_members.new(band_id: params[:band_id])
    band_member.save
    redirect_to request.referer
  end

  def destroy
    band_member = current_user.band_members.find_by(band_id: params[:band_id])
    band_member.destroy
    redirect_to request.referer
  end
  
end
