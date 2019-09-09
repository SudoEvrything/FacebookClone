class LikesController < ApplicationController
	
  def create
    @like = Like.new(like_params)
    if @like.save
      redirect_to @like.post
    else
      flash.now[:danger] = "Error liking post."
      render @like.post
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to @like.post
  end

  private 

    def like_params
      params.require(:like).permit(:user_id, :post_id)
    end
end
