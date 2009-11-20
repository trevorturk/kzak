class UsersController < ApplicationController
    
  def show
    @user = User.find_by_login! params[:id], :include => [:posts, :followings, :followers]
  end
  
end
