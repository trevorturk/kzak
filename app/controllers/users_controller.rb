class UsersController < ApplicationController
    
  def show
    @user = User.find_by_login! params[:id], :include => [:posts, :followings, :followers]
    @feed_items = @user.feed_items.all :include => [:post, :poster]
  end
  
end
