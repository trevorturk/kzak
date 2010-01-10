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
    get :new
    assert_response :success
  end

  # TODO get this test working
  # test "new signs user out if signed in user tries to access" do
  #   sign_in!
  #   assert @controller.current_user.present?
  #   get :new
  #   assert @controller.current_user.blank?
  # end

end
