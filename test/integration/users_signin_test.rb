require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  test "signin with invalid information" do
    get root_path
    #assert_template 'pages/home'
    post signin_path, params: { session: { email: "", password: "" } }
    #assert_template 'pages/home'
    assert_not flash.empty?
    get signup_path
    assert flash.empty?
  end
end
