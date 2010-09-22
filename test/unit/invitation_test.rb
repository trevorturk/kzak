require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

  test "make" do
    i = Invitation.make
    assert i.valid?
  end

  test "generates code before create" do
    i = Invitation.make
    assert i.code.present?
  end

  test "requires user and email" do
    i = Invitation.new
    assert !i.valid?
    assert i.errors[:user_id]
    assert i.errors[:email]
  end

  test "belongs to a user" do
    u = User.make
    i = Invitation.make(:user => u)
    assert_equal u, i.user
  end

  test "validates format of email" do
    i = Invitation.new
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

  test "validates that email isn't already in use" do
    u = User.make
    i = Invitation.new(:email => u.email)
    assert !i.valid?
    assert i.errors[:email]
  end

end
