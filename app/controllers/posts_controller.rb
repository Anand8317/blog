class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user

  def index
    @posts = @user.posts.includes(comments: :user)
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_parameters)
    @post.author_id = @user.id

    if @post.save
      flash[:notice] = 'The post is successfully submitted'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Can not save the post'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_parameters
    params.require(:post).permit(:title, :text)
  end
end
