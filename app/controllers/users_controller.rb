class UsersController < ApplicationController

  def index
    @current_user = current_user
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def show
    @current_user = current_user
  	@user = User.find(params[:id])
  end


  def create
  	@user = User.new(user_params)
  	if @user.save
  		log_in @user
  		flash[:success] = "Welcome, Adios!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

	  def user_params
	  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end

	  def correct_user
	  	@user = User.find(params[:id])
	  	redirect_to(root_url) unless current_user?
	  end
end
