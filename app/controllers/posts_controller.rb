class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :only => :create
  before_filter :get_mime_type, :get_mp3_info, :only => :create
  
  def index
    @posts = Post.all # :include => [:user]
    @users = User.all
  end
    
  def create
    @post = current_user.posts.new(:attachment => params[:Filedata], :title => @title, :artist => @artist, :album => @album)
    if @post.save
      render :partial => @post
    else
     render :action => "new"
    end
  end
  
  # def destroy
  #   @post = current_user.posts.find(params[:id])
  #   @post.destroy
  #   redirect_to root_path
  # end
  
  protected
  
  def get_mime_type
    params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename).to_s
  end
  
  def get_mp3_info
    Mp3Info.open(params[:Filedata].path) do |r|
      @title = r.tag.title
      @artist = r.tag.artist
      @album = r.tag.album
    end
  end
  
end
