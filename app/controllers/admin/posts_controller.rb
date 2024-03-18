class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def destroy #不適切な投稿があれば削除するため
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer
  end
end
