require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase

  test "create" do
    sign_in!
    assert_difference 'Invitation.count' do
      post :create, :invitation => Invitation.plan
    end
    assert_redirected_to root_path
  end

end
