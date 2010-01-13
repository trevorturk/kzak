class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :authenticate_user! # see also config/initializers/devise.rb
end