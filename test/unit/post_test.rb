require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "Post.make" do
    assert_difference 'Post.count' do
      Post.make
    end
  end
    
  test "is not valid without a body" do
    p = Post.new
    assert_equal false, p.valid?
    assert p.errors[:body]
  end
  
  test "is not valid without a user_id" do
    p = Post.new
    assert_equal false, p.valid?
    assert p.errors[:user_id]
  end
  
end
