class HomeController < ApplicationController
  
  def index
    @posts = Post.all :include => [:user]
    @users = User.all
  end
  
end
