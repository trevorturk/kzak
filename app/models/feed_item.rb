class FeedItem < ActiveRecord::Base
  
  attr_accessible # this space intentionally left blank
  
  belongs_to :user
  belongs_to :post
  belongs_to :poster, :foreign_key => 'poster_id', :class_name => 'User'
  
  validates_presence_of :user_id, :post_id, :poster_id, :post_created_at
  validates_uniqueness_of :user_id, :scope => :post_id
  
  default_scope :order => 'post_created_at DESC'
  
  def self.populate(post)
    users = []
    users << post.user # poster's feed
    post.user.followers.each do |follower|
      users << follower # poster's followers' feed
    end if post.user.followers.present?
    users.each do |user|
      FeedItem.insert(user, post)
    end
  end
    
  def self.unpopulate(follower, following)
    FeedItem.find_all_by_user_id_and_poster_id(follower.id, following.id).each {|f| f.destroy} rescue nil
  end
  
  def self.insert(user, post)
    FeedItem.create { |f| f.user_id = user.id; 
      f.post_id = post.id; f.poster_id = post.user_id; f.post_created_at = post.created_at }
  end
  
end
