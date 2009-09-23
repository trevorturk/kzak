class Post < ActiveRecord::Base
  
  attr_accessible :body
  
  belongs_to :user, :counter_cache => :posts_count
  
  validates_presence_of :user_id, :body

  after_create :create_feed_items
  
  default_scope :order => 'created_at DESC'
  
  def create_feed_items
    FeedItem.populate(self)
  end
  
  def to_s
    body
  end
    
end
