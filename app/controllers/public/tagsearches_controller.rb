class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!
  
  def tagsearch
    @word = params[:word]
    @posts = Post.where("category LIKE?", "%#{@word}%").order("id DESC").page(params[:page]).per(5)
  end 

end
