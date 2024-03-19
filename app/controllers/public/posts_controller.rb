class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    flash[:notice] = "投稿を送信しました"
    redirect_to public_posts_path
  end

  def index
    @posts = Post.order("id DESC").page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @user = @post.user
    @post_comments = @post.post_comments.order("id DESC").page(params[:page]).per(4)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "投稿内容を編集しました"
    redirect_to public_post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "投稿を削除しました"
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :category)
  end

end
