class Public::BandsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :band_permits]

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.owner_id = current_user.id
    @band.users << current_user
    if @band.save
      flash[:notice] = "新しくバンドを作成しました"
      redirect_to band_path(@band.id)
    else
      flash.now[:alert] = "バンドの作成に失敗しました"
      render :new
    end
  end

  def index
    @bands = Band.order("id DESC").page(params[:page]).per(5)
  end

  def show
    @band = Band.find(params[:id])
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:notice] = "バンドの情報を更新しました"
      redirect_to band_path(@band.id)
    else
      flash[:alert] = "更新に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    flash[:alert] = "バンドを解散しました"
    redirect_to bands_path
  end

  def band_permits
    @band = Band.find(params[:id])
    @band_permits = @band.band_permits.page(params[:page])
  end

  private

  def band_params
    params.require(:band).permit(:band_image, :name, :introduction, :genre_id, :band_status)
  end

  def ensure_correct_user
    @band = Band.find(params[:id])
    unless @band.owner_id == current_user.id
      redirect_to bands_path, alert: "グループオーナーのみ編集が可能です"
    end
  end

end
