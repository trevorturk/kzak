class PostsController < ApplicationController
  
  before_filter :require_login, :only => [:create, :destroy]
  before_filter :get_mp3_info, :only => :create
  
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
  
  protected
  
  def get_mp3_info
    Mp3Info.open(params[:post][:attachment].path) do |r|
      params[:post][:title] = r.tag.title
      params[:post][:artist] = r.tag.artist
      params[:post][:album] = r.tag.album
    end
    # params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename).to_s # if using swfupload
  rescue
    params[:post][:title] = params[:post][:artist] = params[:post][:album] = 'Unknown'    
  end
  
end
