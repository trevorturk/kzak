class Follow < ActiveRecord::Base

  attr_accessible # this space intentionally left blank

  belongs_to :follower, :class_name => 'User', :counter_cache => :followings_count
  belongs_to :following, :class_name => 'User', :counter_cache => :followers_count

  validates_presence_of :follower_id
  validates_presence_of :following_id
  validates_uniqueness_of :following_id, :scope => :follower_id
  validate :cannot_follow_self

  after_create :backfill_posts
  after_destroy :unbackfill_posts

  default_scope :order => 'created_at DESC'

  def cannot_follow_self
    errors.add(:following_id) if follower == following
  end

  def backfill_posts
    self.following.posts.find_each do |post|
      FeedItem.insert(self.follower, post)
    end
  end

  def unbackfill_posts
    FeedItem.unbackfill(self.follower, self.following)
  end
end