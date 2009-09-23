require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  
  test "Follow.make" do
    assert_difference 'Follow.count' do
      Follow.make
    end
  end
  
  test "requires follower_id, following_id" do
    assert_no_difference 'Follow.count' do
      r = Follow.create
      assert r.errors.on(:following_id)
      assert r.errors.on(:follower_id)
    end
  end
  
  test "following a user backfills the follower's feed with the followed user's posts, unfollowing removes them" do
    user_being_followed = User.make #(:login => 'being_followed')
    user_doing_the_following = User.make #(:login => 'following')
    Time.stubs(:now).returns Time.local(2009,9,1)
    p1 = Post.make(:user => user_being_followed)
    Time.stubs(:now).returns Time.local(2009,9,2)
    p2 = Post.make(:user => user_being_followed)
    assert_equal [p2.id, p1.id], user_being_followed.posts.map(&:id)
    assert_equal [], user_doing_the_following.feed_items
    assert_difference 'FeedItem.count', 2 do
      user_doing_the_following.follow(user_being_followed)
    end
    user_doing_the_following.reload
    assert_equal [p2.id, p1.id], user_doing_the_following.feed_items.map(&:post_id)
    # assert_difference 'FeedItem.count', -2 do
      user_doing_the_following.unfollow(user_being_followed)
    # end
    user_doing_the_following.reload
    assert_equal [], user_doing_the_following.feed_items    
  end
    
end
