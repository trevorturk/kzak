class PostsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create
  before_filter :get_filename, :get_audio_info, :only => :create

  def index
    @feed_items = current_user.feed_items.all :include => {:post => :user}
    @followings = current_user.followings :include => :user

    respond_to do |format|
      format.html
      format.rss
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build :mp3 => params[:Filedata], :title => @title, :artist => @artist, :album => @album
    @post.save!
    render :partial => @post
  rescue => e
    Toadhopper(CONFIG['HOPTOAD_API_KEY']).post!(e) if CONFIG['HOPTOAD_API_KEY']
    render :partial => 'error', :locals => {:filename => @filename}
  end

  protected

  def get_filename
    @filename ||= params[:Filedata].original_filename rescue nil # for posts/new form
  end

  def get_audio_info
    if @filename =~ /.mp3$/
      Mp3Info.open(params[:Filedata].path) do |r|
        @title = r.tag.title
        @artist = r.tag.artist
        @album = r.tag.album
      end
    elsif @filename =~ /.mp4$|.m4a$/
      info = MP4Info.open(params[:Filedata].path)
      @title = info.send(:NAM)
      @artist = info.send(:ART)
      @album = info.send(:ALB)
    end
    @title = @title.toutf8 rescue 'Unknown'
    @artist = @artist.toutf8 rescue 'Unknown'
    @album = @album.toutf8 rescue 'Unknown'
  end
end