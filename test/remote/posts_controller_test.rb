# require File.dirname(__FILE__) + '/../test_helper'
# 
# class PostsControllerTest < ActionController::TestCase
#   
#   # ===
#   # NOTE these are real remote requests that can be run with "rake test:remote" - they won't be run with autotest
#   # ===
#     
#   test "should create post via (real) url" do
#     assert_difference 'Post.count' do
#       post :create, :post => { :attachment_url => 'http://www.google.com/intl/en_ALL/images/logo.gif' }
#     end
#     assert_redirected_to root_path
#   end
#   
#   test "should not bomb on post via bogus (real) url" do
#     assert_no_difference 'Post.count' do
#       post :create, :post => { :attachment_url => 'invalid' }
#     end
#     assert_response :success
#   end
#       
# end
