class Public::PostCommentsController < ApplicationController
    before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.score = Language.get_data(post_comment_params[:comment])
    if comment.save
      flash[:notice] = "コメントを送信しました"
      redirect_to request.referer
    else 
      flash[:alert] = "コメント送信に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    @post = Post.find(params[:post_id])
    flash[:notice] = "コメントを削除しました"
    redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
