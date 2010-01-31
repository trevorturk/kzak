require 'mp3info'

class Post < ActiveRecord::Base

  include ActionView::Helpers::TextHelper # truncate
  include ERB::Util # h

  attr_accessible :attachment, :title, :artist, :album

  if CONFIG['s3']
    has_attached_file :attachment, :storage => :s3, :path => ":filename", :bucket => CONFIG['s3_bucket_name'],
        :s3_permissions => 'private', :s3_protocol => 'http',
        :s3_host_alias => CONFIG['s3_host_alias'], :url => CONFIG['s3_host_alias'] ? ':s3_alias_url' : nil,
        :s3_credentials => { :access_key_id => CONFIG['s3_access_id'], :secret_access_key => CONFIG['s3_secret_key'] },
        :s3_headers => { 'Cache-Control' => 'max-age=315576000', 'Expires' => 99.years.from_now.httpdate }
  else
    has_attached_file :attachment, :storage => :filesystem, :url => "/system/:filename"
  end

  belongs_to :user, :counter_cache => :posts_count

  validates_presence_of :user_id, :attachment_file_name

  before_create :randomize_file_name
  after_create :cache_s3_url, :create_feed_items
  after_destroy :destroy_feed_items

  default_scope :order => 'created_at DESC'

  def create_feed_items
    FeedItem.populate(self)
  end

  def destroy_feed_items
    FeedItem.unpopulate(self)
  end

  def attachment_url
    CONFIG['s3'] ? s3_url : attachment.url
  end

  def cache_s3_url
    if CONFIG['s3']
      self.s3_url = attachment.s3.interface.get_link(attachment.s3_bucket.to_s, attachment.path, 364.days)
      self.s3_url_created_at = Time.zone.now
      self.save!
    end
  end

  def to_s
    attachment_file_name
  end

  def to_string
    truncate "[#{h user}] #{h title} &mdash; #{h artist} &mdash; #{h album}", :length => 120
  end

  protected

  def randomize_file_name
    extension = File.extname(attachment_file_name).downcase
    self.attachment.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(20)}#{extension}")
  end
end