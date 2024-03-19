class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @post_comments = PostComment.page(params[:page]).per(7)
  end
  
  def destroy #不適切なコメントがあれば削除するため
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    flash[:alert] = "コメントを削除しました"
    redirect_to request.referer
  end
  
end
