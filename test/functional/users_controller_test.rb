require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "show" do
    u = User.make
    get :show, :id => u.login
    assert_redirected_to new_user_session_path(:unauthenticated => true)
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

  # TODO get this test working
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
    assert_equal 2, User.count
    assert_equal 0, Follow.count
    assert_difference 'User.count' do
      post :create, :user => {:invitation => i.code, :email => i.email, :login => 'test', :password => 'test', :password_confirmation => 'test'}
      assert_redirected_to root_path
    end
    i.reload
    u2 = User.last
    assert_equal nil, i.code
    assert_equal u2, i.new_user
    assert_equal i.user, u2.inviter
    assert_equal 4, Follow.count # new users follow and are followed by all users
    assert u0.following?(u2)
    assert u1.following?(u2)
    assert u2.following?(u1)
  end

end
