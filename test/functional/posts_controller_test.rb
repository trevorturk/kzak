require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  test "index" do
    get :index
    assert_redirected_to new_user_session_path(:unauthenticated => true)
    sign_in!
    get :index
    assert_response :success
  end

  test "create" do
    sign_in!
    assert_difference('Post.count') do
      post :create, :Filedata => fixture_file_upload('files/audio.mp3', 'audio/mpeg')
    end
    assert_response :success
    r = Post.last
    assert r.attachment_file_name != 'audio.mp3' # check for random file name
    assert_equal 'audio/mpeg', r.attachment_content_type
    assert_equal 174208, r.attachment_file_size # check for correct file size
    assert_equal 'The Love Song of J. Alfred Prufrock', r.title
    assert_equal 'T.S. Eliot', r.artist
    assert_equal 'Prufrock and Other Observations', r.album
  end

  test "create requires login" do
    assert_no_difference('Post.count') do
      post :create, :Filedata => fixture_file_upload('files/audio.mp3', 'audio/mpeg')
    end
    assert_redirected_to new_user_session_path(:unauthenticated => true)
  end

  # test "should create post via (stubbed out) url" do
  #   sign_in!
  #   Post.any_instance.expects(:do_download_remote_file).returns(File.open("#{Rails.root}/test/fixtures/files/audio.mp3"))
  #   assert_difference 'Post.count' do
  #     post :create, :Filedata => 'audio.mp3'
  #   end
  #   assert_redirected_to root_path
  # end
  #
  # test "should not bomb on post via bogus (stubbed out) url" do
  #   sign_in!
  #   Post.any_instance.expects(:do_download_remote_file).returns(nil)
  #   assert_no_difference 'Post.count' do
  #     post :create, :Filedata => 'invalid'
  #   end
  #   assert_response :success
  # end

  # test "should destroy post" do
  #   u = sign_in!
  #   p = Post.make(:user => u)
  #   assert_difference('Post.count', -1) do
  #     delete :destroy, :id => p.to_param
  #   end
  #   assert_redirected_to root_path
  # end
  #
  # test "destroy requires login" do
  #   delete :destroy, :id => Post.make.id
  #   assert_redirected_to login_path
  # end

end
