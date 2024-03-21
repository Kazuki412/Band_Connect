class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!
  
  def tagsearch
    @word = params[:word]
    @posts = Post.where("category LIKE?", "%#{@word}%").page(params[:page]).per(5)
  end 

end
