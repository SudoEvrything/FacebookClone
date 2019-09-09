class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment added."
      redirect_to @comment.post
    else
      flash.now[:danger] = "Couldn't create comment - try again."
      render @comment.post
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated."
      redirect_to @comment.post
    else
      flash.now[:danger] = "There was a problem updating the comment."
      render @comment.post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to @comment.post
  end

  private 

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
