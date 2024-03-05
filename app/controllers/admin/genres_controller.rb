class Admin::GenresController < ApplicationController
  # 管理者以外はアクセスできないように
  before_action :authenticate_admin!
  
  def index #indexページに新規作成フォームを実装しているのでGenre.newを定義しています。
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path #ジャンル一覧へ遷移
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path #ジャンル一覧へ遷移
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end