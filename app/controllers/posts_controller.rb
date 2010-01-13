class PostsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :get_mime_type, :get_mp3_info, :only => :create

  def index
    @feed_items = current_user.feed_items.all :include => {:post => :user}
    @users = User.all
  end

  def create
    @post = current_user.posts.new :attachment => params[:Filedata], :title => @title, :artist => @artist, :album => @album
    if @post.save!
      render :partial => @post
    else
      flash[:error] = 'Sorry, there as an error processing this file'
      redirect_to root_path
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
      @title = r.tag.title || 'Unknown'
      @artist = r.tag.artist || 'Unknown'
      @album = r.tag.album || 'Unknown'
    end
  end
end