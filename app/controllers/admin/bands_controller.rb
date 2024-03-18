class Admin::BandsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def update #素行の悪いバンドを取り締まるため、問題アリと表示させることができます、取り消しも可能
    @band = Band.find(params[:id])
    @band.update(band_params)
    flash[:notice] = "バンドの情報を更新しました"
    redirect_to request.referer
  end
  
  private
  
  def band_params
    params.require(:band).permit(:band_status2)
  end
  
end
