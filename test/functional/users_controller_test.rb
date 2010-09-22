require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "show" do
    u = User.make
    get :show, :id => u.login
    assert_redirected_to new_user_session_path
    sign_in!
    get :show, :id => u.login
    assert_response :success
    u.posts.make
    get :show, :id => u.login
    assert_response :success
  end

  test "new" do
    get :new, :invitation => Invitation.make.code
    assert_response :success
  end

  test "new with bad invite" do
    get :new, :invitation => 'invalid'
    assert_redirected_to root_path
  end

  # TODO fix test
  # test "new signs user out if signed in user tries to access" do
  #   sign_in!
  #   assert @controller.current_user.present?
  #   get :new
  #   assert @controller.current_user.blank?
  # end

  test "create" do
    u0 = User.make
    u1 = User.make
    i = Invitation.make(:user => u1, :email => 'test@example.com')
    # follows
    assert_equal 2, User.count
    assert_equal 0, Follow.count
    # sign up
    assert_difference 'User.count' do
      post :create, :user => {:invitation => i.code, :email => i.email, :login => 'test', :password => 'test', :password_confirmation => 'test'}
      assert_redirected_to root_path
    end
    i.reload
    u2 = User.last
    # invitation
    assert_equal nil, i.code
    assert_equal u2, i.new_user
    assert_equal i.user, u2.inviter
    assert i.redeemed_at.present?
    # follows (new users follow all users and are followed by all users)
    assert_equal 4, Follow.count
    assert !u0.following?(u1) # existing users don't follow each other
    assert u0.following?(u2) # existing users follow new user
    assert !u1.following?(u0) # existing users don't follow each other
    assert u1.following?(u2) # existing users follow new user
    assert u2.following?(u0) # new users follow all existing users
    assert u2.following?(u1) # new users follow all existing users
    # sign in and redirect
    # assert @controller.signed_in?(:user) # TODO fix test
    assert_redirected_to root_path
  end

end
