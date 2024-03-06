class Admin::MusicalInstrumentsController < ApplicationController
  # 管理者以外はアクセスできないように
  before_action :authenticate_admin!
  
  def index #indexページに新規作成フォームを実装しているのでMusical_instrument.newを定義しています。
    @musical_instrument = MusicalInstrument.new
    @musical_instruments = MusicalInstrument.all
  end

  def create
    @musical_instrument = MusicalInstrument.new(musical_instrument_params)
    @musical_instrument.save
    redirect_to admin_musical_instruments_path #楽器一覧へ遷移
  end

  def edit
    @musical_instrument = MusicalInstrument.find(params[:id])
  end

  def update
    @musical_instrument = MusicalInstrument.find(params[:id])
    @musical_instrument.update(musical_instrument_params)
    redirect_to admin_musical_instruments_path #楽器一覧へ遷移
  end

  private

  def musical_instrument_params
    params.require(:musical_instrument).permit(:name)
  end

end 
