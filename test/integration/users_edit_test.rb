require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
  end

  test "unsuccessful edit" do
    sign_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: "",
      email: 'invalid@email',
      password: 'foo',
      password_confirmation: 'bar' } }
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    sign_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert session[:forwarding_url] == nil
    patch user_path(@user), params: { user: {
      name: "Valid",
      email: "valid@email.com",
      password: "",
      password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.email, "valid@email.com"
  end
end
