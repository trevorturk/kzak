require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "new" do
    get :new
    assert_response :success
  end

  test "create" do
    u = User.make(:password => 'test', :password_confirmation => 'test')
    assert !warden.authenticated?(:user)
    assert u.sign_in_count.nil?
    post :create, :user => {:login => u.login, :password => 'test'}
    assert warden.authenticated?(:user)
    u.reload
    assert u.sign_in_count == 1
  end

  test "failed sign in" do
    u = User.make(:password => 'test', :password_confirmation => 'test')
    assert !warden.authenticated?(:user)
    post :create, :user => {:login => u.login, :password => 'something else'}
    assert !warden.authenticated?(:user)
  end
end