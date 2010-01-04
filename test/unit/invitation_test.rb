require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

  test "make" do
    i = Invitation.make
    assert i.valid?
  end
  
  test "requires and belongs to a user" do
  end

end
