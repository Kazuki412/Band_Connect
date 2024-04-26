class Admin::MotivationsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @motivation = Motivation.new(motivation_params)
    @motivation.save
    redirect_to admin_motivations_path
  end

  def index
    @motivation = Motivation.new
    @motivations = Motivation.all
  end

  def edit
    @motivation = Motivation.find(params[:id])
  end

  def update
    @motivation = Motivation.find(params[:id])
    @motivation.update(motivation_params)
    redirect_to admin_motivations_path
  end

  private

  def motivation_params
    params.require(:motivation).permit(:name)
  end
end
