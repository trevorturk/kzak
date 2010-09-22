class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! # see also config/initializers/devise.rb
end