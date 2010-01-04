require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase

  test "create" do
    sign_in!
    assert_difference 'Invitation.count' do
      post :create, :invitation => Invitation.plan
    end
    assert_redirected_to root_path
  end
  
  test "create requires login" do
    assert_no_difference 'Invitation.count' do
      post :create, :invitation => Invitation.plan
    end
    assert_redirected_to new_user_session_path(:unauthenticated => true)
  end
  
  test "create fails gracefully" do
    sign_in!
    assert_no_difference 'Invitation.count' do
      post :create, :invitation => {}
    end
    assert_redirected_to root_path
  end
  
  test "create sends an email" do
    Mailer.expects(:deliver_invitation)
    sign_in!
    post :create, :invitation => Invitation.plan
  end

end
