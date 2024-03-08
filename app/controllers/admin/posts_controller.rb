class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def show
  end

  def destroy
  end
end
