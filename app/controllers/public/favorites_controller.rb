class Public::FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post)
    favorite.save
    # redirect_to request.referer ←非同期通信のためコメントアウト
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post)
    favorite.destroy
    # redirect_to request.referer ←非同期通信のためコメントアウト
  end
end
