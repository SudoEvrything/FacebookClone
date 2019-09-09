class HomeController < ApplicationController
  def index
  	if logged_in?
	  	render 'posts/show'
	  end
  end
end
