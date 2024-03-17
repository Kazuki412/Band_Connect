class Admin::BandsController < ApplicationController
  
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)
    flash[:notice] = "バンドの情報を更新しました"
    redirect_to admin_band_path(@band.id)
  end
  
  private
  
  def band_params
    params.require(:band).permit(:band_status2)
  end
  
end
