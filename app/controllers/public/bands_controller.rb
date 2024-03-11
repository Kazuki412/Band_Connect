class Public::BandsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :band_permits]
  
  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.owner_id = current_user.id
    @band.users << current_user
    @band.save
    flash[:notice] = "新しくバンドを作りました"
    redirect_to public_bands_path
  end

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)
    flash[:notice] = "バンドの情報を更新しました"
    redirect_to public_bands_path
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    flash[:alert] = "バンドを解散しました"
    redirect_to public_bands_path
  end
  
  def band_permits
    @band = Band.find(params[:id])
    @band_permits = @band.band_permits.page(params[:page])
  end
  
  private
  
  def band_params
    params.require(:band).permit(:band_image, :name, :introduction, :genre_id)
  end
  
  def ensure_correct_user
    @band = Band.find(params[:id])
    unless @band.owner_id == current_user.id
      redirect_to public_bands_path, alert: "グループオーナーのみ編集が可能です"
    end 
  end 

end
