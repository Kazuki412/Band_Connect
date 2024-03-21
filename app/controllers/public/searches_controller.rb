class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @word = params[:word]
    @model = params[:model]
    if @model == "Band"
      @bands = Band.looks(params[:search], params[:word]).page(params[:page]).per(5)
    elsif @model == "Post"
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(5)
    elsif @model == "User"
      @users = User.looks(params[:search], params[:word]).page(params[:page]).per(5)
    end
  end
end
