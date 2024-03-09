class Public::TagsearchesController < ApplicationController
  
  def tagsearch
    @word = params[:word]
    @posts = Post.where("category LIKE?", "%#{@word}%")
  end 

end
