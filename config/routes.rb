Kzak::Application.routes.draw do
  root :to => 'posts#index'
  resources :posts, :only => [:index, :new, :create]
  resources :invitations, :only => [:create]
  resources :users, :only => [:new, :create]
  devise_for :users
  # NOTE last route to avoid namespace issues
  match ':id' => 'users#show', :as => :user
end