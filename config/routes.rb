ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'posts'
  map.resources :posts, :only => [:index, :create, :destroy]
  map.login '/login', :controller => 'home'
  
  # NOTE users should be last route set to avoid namespace issues
  map.with_options :controller => 'users' do |u|
    u.user            '/:id',             :action => 'show'
    u.following_user  '/:id/following',   :action => 'following'
    u.followers_user  '/:id/followers',   :action => 'followers'
    u.follow_user     '/:id/follow',      :action => 'follow',    :conditions => { :method => :post }
    u.unfollow_user   '/:id/unfollow',    :action => 'unfollow',  :conditions => { :method => :post }
  end
end
