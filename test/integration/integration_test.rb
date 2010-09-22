require 'test_helper'

class IntegrationTest < ActionController::IntegrationTest

  test "password reset" do
    u = User.make
    get 'users/password/new'
    assert_response :success
    assert_difference 'ActionMailer::Base.deliveries.size' do
      post 'users/password', :user => {:email => u.email}
    end
    assert_redirected_to new_user_session_path
    get "users/password/edit?reset_password_token=#{u.reset_password_token}"
    assert_response :success
    put 'users/password', :user => {:password => 'test', :password_confirmation => 'test', :reset_password_token => u.reset_password_token}
    # TODO figure out how to rest successful and unsuccessful password resets
    # assert_redirected_to root_path
  end
end