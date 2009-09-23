require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "User.make" do
    assert_difference 'User.count' do
      User.make
    end
  end
  
  test "has many posts" do
    u = User.make
    r = Post.make(:user => u)
    assert_equal u.posts, [r]
  end
  
  test "has many followings/followers" do
    user_doing_the_following = User.make
    user_being_followed = User.make
    Follow.make(:follower_id => user_doing_the_following.id, :following_id => user_being_followed.id)
    assert_equal [user_doing_the_following], user_being_followed.followers
    assert_equal [user_being_followed], user_doing_the_following.followings
  end
  
  test "follow" do
    user_doing_the_following = User.make
    user_being_followed = User.make
    assert_difference 'Follow.count' do
      user_doing_the_following.follow(user_being_followed)
      assert_equal [user_doing_the_following], user_being_followed.followers
      assert_equal [user_being_followed], user_doing_the_following.followings
      user_doing_the_following.reload
      user_being_followed.reload
      assert_equal 1, user_doing_the_following.followings_count
      assert_equal 1, user_being_followed.followers_count
    end
  end
  
  test "unfollow" do
    user1 = User.make
    user2 = User.make
    user1.follow(user2)
    assert_difference 'Follow.count', -1 do
      user1.unfollow(user2)
      assert_equal [], user1.followings
      assert_equal [], user2.followers
    end
  end
  
  test "following?" do
    user_doing_the_following = User.make
    user_being_followed = User.make
    assert !user_doing_the_following.following?(user_being_followed)
    user_doing_the_following.follow(user_being_followed)
    assert user_doing_the_following.following?(user_being_followed)
  end
  
  test "follows are unique and attempts to create two followings doesn't bomb" do
    user1 = User.make
    user2 = User.make
    assert_difference 'Follow.count' do
      user1.follow(user2)
    end
    assert_no_difference 'Follow.count' do
      user1.follow(user2)
    end
  end
  
  test "can follow each other" do
    user1 = User.make
    user2 = User.make
    assert_difference 'Follow.count' do
      user1.follow(user2)
    end
    assert_difference 'Follow.count' do
      user2.follow(user1)
    end
  end
  
  test "cannot follow self but doesn't bomb" do
    user = User.make
    assert_nothing_raised do
      assert_no_difference 'Follow.count' do
        user.follow(user)
      end
    end
  end
  
  test "unfollow doesn't bomb if nothing found" do
    assert_nothing_raised do
      User.make.unfollow(User.make)
    end
  end
    
  test "to_param" do
    u = User.make
    assert_equal u.login, u.to_param
  end
  
  test "to_s" do
    u = User.make
    assert_equal u.login, u.to_s
  end

end
