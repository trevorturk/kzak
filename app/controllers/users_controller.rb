class UsersController < ApplicationController
  
  def show
    @user = User.find_by_login!(params[:id], :include => [:posts, :followings, :followers])
  end
  
  def new
    #
  end
  
  def create
    # note who the user was invited by
  end
    
end
