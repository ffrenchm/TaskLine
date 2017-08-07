ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all

  # Returns true if a test user is logged in.
  def is_signed_in?
    !session[:user_id].nil?
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user - cant use sessions directly in integration tests
  def sign_in_as(user, password: 'password')
    post signin_path, params: { session: { email: user.email,
                                          password: password } }
  end
end
