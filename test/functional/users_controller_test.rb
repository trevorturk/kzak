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

end
