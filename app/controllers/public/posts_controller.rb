class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.score = Language.get_data(post_params[:body])
    if @post.save
      flash[:notice] = "投稿を送信しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
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
    @post.score = Language.get_data(post_params[:body])
    if @post.update(post_params)
      flash[:notice] = "投稿内容を更新しました"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "投稿内容の更新に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "投稿を削除しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :category)
  end

  def ensure_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path, alert: '他ユーザーの投稿は編集はできません'
    end
  end

end
