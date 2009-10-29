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

  test "file name is randomized on create" do
    Post.any_instance.expects(:do_download_remote_file).returns(File.open("#{Rails.root}/test/fixtures/files/audio.mp3"))
    r = Post.create! { |r| r.user = User.make; r.attachment = nil; r.attachment_url = 'audio.mp3' }
    assert r.attachment_file_name != 'audio.mp3'
  end

  test "should create an post via (stubbed out) url" do
    Post.any_instance.expects(:do_download_remote_file).returns(File.open("#{Rails.root}/test/fixtures/files/audio.mp3"))
    r = Post.create! { |r| r.user = User.make; r.attachment = nil; r.attachment_url = 'audio.mp3' }
    assert_equal 'audio.mp3', r.attachment_remote_url
    assert_equal 'application/x-mp3', r.attachment_content_type
    assert_equal 174208, r.attachment_file_size # check for correct file size
    assert_equal 'The Love Song of J. Alfred Prufrock', r.title
    assert_equal 'T.S. Eliot', r.artist
    assert_equal 'Prufrock and Other Observations', r.album
  end

  test "should require post provided via (stubbed out) url to be valid" do
    Post.any_instance.expects(:do_download_remote_file).returns(nil)
    assert_no_difference 'Post.count' do
      r = Post.create(:user => User.make, :attachment => nil, :attachment_url => 'invalid')
      assert r.errors.on(:attachment_file_name)
    end
  end
  
end
