class PostsController < ApplicationController
  
  before_filter :require_login, :only => [:create, :destroy]
  
  def index
    @posts = Post.all :include => [:user]
    @users = User.all
  end
  
  def create
    @post = current_user.posts.new(params[:post])
    if @post.save
      redirect_to root_path
    else
      render :action => "index"
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

end
