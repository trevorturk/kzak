class ApplicationController < ActionController::Base
  # see config/initializers/devise.rb as well
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  before_filter :authenticate_user!
end