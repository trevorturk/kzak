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
    render :partial => 'posts/post.html.erb', :locals => {:post => @post}
  rescue => e
    Toadhopper(CONFIG['HOPTOAD_API_KEY']).post!(e) if CONFIG['HOPTOAD_API_KEY']
    render :partial => 'posts/error.html.erb', :locals => {:filename => @filename}
  end

  protected

  def get_filename
    @filename ||= params[:Filedata].original_filename if params[:Filedata]
  end

  def get_audio_info
    return unless params[:Filedata]

    path = params[:Filedata].respond_to?(:path) ? params[:Filedata].path : params[:Filedata].tempfile.path

    if @filename =~ /.mp3$/
      Mp3Info.open(path) do |r|
        @title = r.tag.title
        @artist = r.tag.artist
        @album = r.tag.album
      end
    elsif @filename =~ /.mp4$|.m4a$/
      info = MP4Info.open(path)
      @title = info.send(:NAM)
      @artist = info.send(:ART)
      @album = info.send(:ALB)
    end

    @title = @title.toutf8 rescue 'Unknown'
    @artist = @artist.toutf8 rescue 'Unknown'
    @album = @album.toutf8 rescue 'Unknown'
  end

end