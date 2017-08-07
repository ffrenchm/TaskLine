require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
  end

  test "signin with invalid information" do
    get root_path
    assert_select "a[href=?]", signup_path
    post signin_path, params: { session: { email: "", password: "" } }
    assert_not flash.empty?
    assert_select "a[href=?]", signout_path, count: 0
  end

  test "signin with valid information" do
    get root_path
    post signin_path, params: { session: { email: @user.email,
                                           password: 'password'}}
    assert is_signed_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", signup_path, count: 0
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", signout_path, count: 0
  end
end
