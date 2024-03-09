class Admin::PostCommentsController < ApplicationController
  
  def index
    @post_comments = PostComment.all
    @users = User.all
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to request.referer
  end
  
end
