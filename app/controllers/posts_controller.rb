class PostsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :get_audio_info, :only => :create

  def index
    @feed_items = current_user.feed_items.all :include => {:post => :user}
    @users = User.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build :attachment => params[:Filedata],
        :title => @title || 'Unknown', :artist => @artist || 'Unknown', :album => @album || 'Unknown'
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

  def get_audio_info
    params[:Filename] ||= params[:Filedata].original_filename rescue nil # via form on posts/new

    if params[:Filename] =~ /mp3/
      Mp3Info.open(params[:Filedata].path) do |r|
        @title = r.tag.title
        @artist = r.tag.artist
        @album = r.tag.album
      end
    elsif params[:Filename] =~ /mp4|m4a/
      info = MP4Info.open(params[:Filedata].path)
      @title = info.send(:NAM)
      @artist = info.send(:ART)
      @album = info.send(:ALB)
    end
  end
end