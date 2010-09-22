require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "User.make" do
    assert_difference 'User.count' do
      User.make
    end
  end

  test "is not valid without login" do
    u = User.new
    assert_equal false, u.valid?
    assert u.errors[:login]
  end

  test "is not valid without unique login" do
    User.make(:login => 'test')
    u = User.new(:login => 'test')
    assert_equal false, u.valid?
    assert u.errors[:login]
  end

  test "is not valid with login greater than 15" do
    u = User.new(:login => '1234567890123456')
    assert_equal false, u.valid?
    assert u.errors[:login]
  end

  test "is not valid with login that begins with a number or underscore " do
    u = User.new(:login => '1a'); assert_equal false, u.valid?; assert u.errors[:login]
    u = User.new(:login => '_a'); assert_equal false, u.valid?; assert u.errors[:login]
  end

  test "is not valid with login that's not all letters, numbers, and underscores" do
    u = User.new(:login => '@'); assert_equal false, u.valid?; assert u.errors[:login]
    u = User.new(:login => '!'); assert_equal false, u.valid?; assert u.errors[:login]
    u = User.new(:login => '~'); assert_equal false, u.valid?; assert u.errors[:login]
  end

  test "validates format of email" do
    i = User.new
    i.email = 'with a space'
    assert !i.valid?
    assert i.errors[:email]
    i.email = 'invalid!chars'
    assert !i.valid?
    assert i.errors[:email]
    i.email = 'no_domain'
    assert !i.valid?
    assert i.errors[:email]
  end

  test "validate unique email" do
    u1 = User.make(:email => 'test@example.com')
    assert u1.valid?
    u2 = User.new
    u2.email = 'test@example.com'
    assert !u2.valid?
    assert u2.errors[:email]
  end

  test "has many posts" do
    u = User.make
    r = Post.make(:user => u)
    assert_equal u.posts, [r]
  end

  test "has many invitations" do
    u = User.make
    r = Invitation.make(:user => u)
    assert_equal u.invitations, [r]
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

  test "follow all users" do
    user1 = User.make
    user2 = User.make
    assert_difference 'Follow.count' do
      user1.follow_all_users
    end
    assert user1.following?(user2)
  end

  test "get followed by all users" do
    user1 = User.make
    user2 = User.make
    assert_difference 'Follow.count' do
      user1.get_followed_by_all_users
    end
    assert user2.following?(user1)
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
