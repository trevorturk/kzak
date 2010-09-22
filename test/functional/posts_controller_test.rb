require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  test "index" do
    get :index
    assert_redirected_to new_user_session_path
    u = sign_in!
    get :index
    assert_response :success
    Post.make
    u.posts.make
    get :index
    assert_response :success
  end

  test "index shows posts in user's feed_items" do
    u1 = sign_in!
    u2 = User.make
    p = u2.posts.make
    get :index
    assert assigns(:feed_items).blank?
    u1.follow(u2)
    get :index
    assert !assigns(:feed_items).blank?
    assert assigns(:feed_items).first.post == p
    u1.unfollow(u2)
    get :index
    assert assigns(:feed_items).blank?
  end

  test "rss" do
    u = User.make
    get :index, :format => 'rss' # no token
    assert_response :unauthorized
    get :index, :format => 'rss', :auth_token => '' # blank token
    assert_response :unauthorized
    get :index, :format => 'rss', :auth_token => 'invalid' # invalid token
    assert_response :unauthorized
    # TODO get rss tests working somehow
    # get :index, :format => 'rss', :auth_token => u.authentication_token # valid token
    # assert_response :success
    # Post.make
    # u.posts.make
    # get :index, :format => 'rss', :auth_token => u.authentication_token # with content
    # assert_response :success
  end

  test "create" do
    sign_in!
    assert_difference('Post.count') do
      post :create, :Filename => 'audio.mp3', :Filedata => fixture_file_upload('files/audio.mp3', 'audio/mpeg')
    end
    assert_response :success
    r = Post.last
    assert r.mp3 != 'audio.mp3' # check for random file name
    assert_equal 'The Love Song of J. Alfred Prufrock', r.title
    assert_equal 'T.S. Eliot', r.artist
    assert_equal 'Prufrock and Other Observations', r.album
  end

  test "m4a files are parsed correctly" do
    sign_in!
    assert_difference('Post.count') do
      post :create, :Filename => 'audio.m4a', :Filedata => fixture_file_upload('files/audio.m4a', 'audio/mpeg')
    end
    r = Post.last
    assert_equal 'Shut Down', r.title
    assert_equal 'Matt Besser', r.artist
    assert_equal 'May I Help You (Dumbass)?', r.album
  end

  test "create requires login" do
    assert_no_difference('Post.count') do
      post :create, :Filedata => fixture_file_upload('files/audio.mp3', 'audio/mpeg')
    end
    assert_redirected_to new_user_session_path
  end

  test "create fails gracefully" do
    sign_in!
    assert_no_difference('Post.count') do
      post :create
    end
    assert_response :success
  end

  test "new" do
    get :new
    assert_redirected_to new_user_session_path
    sign_in!
    get :new
    assert_response :success
  end

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
