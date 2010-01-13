class ApplicationController < ActionController::Base
  # see also config/initializers/devise.rb
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :authenticate_user!
end