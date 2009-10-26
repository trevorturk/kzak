require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  test "create requires login" do
    post :create, :post => Post.plan
    assert_redirected_to login_path
  end
  
  test "destroy requires login" do
    delete :destroy, :id => Post.make.id
    assert_redirected_to login_path
  end
  
  test "should create post" do
    login!
    assert_difference('Post.count') do
      post :create, :post => { :attachment => fixture_file_upload('files/rails.png', 'image/png') }
    end
    assert_redirected_to root_path
  end

  test "should create post via (stubbed out) url" do
    login!
    Post.any_instance.expects(:do_download_remote_file).returns(File.open("#{Rails.root}/test/fixtures/files/rails.png"))
    assert_difference 'Post.count' do
      post :create, :post => { :attachment_url => 'rails.png' }
    end
    assert_redirected_to root_path
  end
  
  test "should not bomb on post via bogus (stubbed out) url" do
    login!
    Post.any_instance.expects(:do_download_remote_file).returns(nil)
    assert_no_difference 'Post.count' do
      post :create, :post => { :attachment_url => 'invalid' }
    end
    assert_response :success
  end
  
  test "should destroy post" do
    u = login!
    p = Post.make(:user => u)
    assert_difference('Post.count', -1) do
      delete :destroy, :id => p.to_param
    end
    assert_redirected_to root_path
  end


end
