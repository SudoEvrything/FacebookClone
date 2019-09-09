class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@like = current_user.user_like(@post)
	end

	def new
		@post = Post.new
	end
		
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Posted on your pages"
			redirect_to post_path(post)
		else
			flash[:danger] = "Unable to post update"
			render 'new'
		end
	end

	def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
      redirect_to @post
    else
      flash.now[:danger] = "Couldn't update post - try again."
      render 'edit'
    end
  end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to request.referrer || root_url
	end

	private
		
		def post_params
			params.require(:post).permit(:user_id, :content)
		end

		def correct_user
			@post = current_user.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end
end
