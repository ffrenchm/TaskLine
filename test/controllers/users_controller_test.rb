require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:matt)
    @hacker = users(:hacker)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not signed in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect update when not signed in" do
    patch user_path(@user), params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect destroy when not signed in" do
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect edit for wrong user" do
    sign_in_as @hacker
    get edit_user_path(@user)
    assert_redirected_to root_path
  end

  test "should redirect update for wrong user" do
    sign_in_as @hacker
    patch user_path(@user), params: { user: { email: @user.email } }
    assert_redirected_to root_path
  end

  test "should redirect destroy for wrong user" do
    sign_in_as @hacker
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end

  test "should destroy user if correct user issues request" do
    sign_in_as @user
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end
end
