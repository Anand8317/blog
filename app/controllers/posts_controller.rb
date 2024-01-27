class PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.Post.all
  end

  def show
    @post = @user.Post.find(params[:post_id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
