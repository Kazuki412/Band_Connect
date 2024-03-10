class Public::BandMembersController < ApplicationController
  
  def create
    @group = Group.find(params[:group_id])
    @band_permit = BandPermit.find(params[:band_permit_id])
    @band_member = BandMember.create(user_id: @band_permit.user_id, group_id: params[:group_id])
    @band_permit.destroy
    redirect_to request.referer
  end

  def destroy
    band_member = current_user.band_members.find_by(band_id: params[:band_id])
    band_member.destroy
    redirect_to request.referer
  end
  
end
