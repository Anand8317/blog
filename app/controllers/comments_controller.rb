class CommentsController < ApplicationController

  def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'The comment is successfully submitted'
      render json: @comment, status: :created
      #redirect_to user_post_path(@post.author, @post)
    else
      render json: @comment.errors, status: :unprocessable_entity
      #render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
