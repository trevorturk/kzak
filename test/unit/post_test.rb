require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "Post.make" do
    assert_difference 'Post.count' do
      Post.make
    end
  end

  test "is not valid without a user_id" do
    p = Post.new
    assert_equal false, p.valid?
    assert p.errors[:user_id]
  end

  test "to_s returns attachment_file_name" do
    r = Post.make
    assert_equal r.attachment_file_name, r.to_s
  end

end
