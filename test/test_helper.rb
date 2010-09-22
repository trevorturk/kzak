ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require 'rails/test_help'

class ActiveSupport::TestCase

  setup do
    Sham.reset
  end

  def sign_in!(options = {})
    user = User.make(options)
    sign_in user
    user
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end