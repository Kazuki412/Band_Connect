class Admin::BandsController < ApplicationController
  
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
  end

  def edit
  end

  def update
  end
end
