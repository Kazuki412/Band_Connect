class Public::SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @model = params[:model]
    if @model == "Band"
      @bands = Band.looks(params[:search], params[:word])
    elsif @model == "Post"
      @posts = Post.looks(params[:search], params[:word])
    elsif @model == "User"
      @users = User.looks(params[:search], params[:word])
    end
  end
end
