class Post < ActiveRecord::Base
  include ActionView::Helpers::TextHelper # truncate
  include ERB::Util # h

  attr_accessible :mp3, :title, :artist, :album

  mount_uploader :mp3, Mp3Uploader

  belongs_to :user, :counter_cache => :posts_count

  validates_presence_of :user_id, :mp3

  after_create :create_feed_items
  after_destroy :destroy_feed_items

  def create_feed_items
    FeedItem.populate(self)
  end

  def destroy_feed_items
    FeedItem.unpopulate(self)
  end

  def to_s
    sanitize(truncate("[#{h user}] #{h title} &mdash; #{h artist} &mdash; #{h album}", :length => 120))
  end
end