require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "signup with valid information" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: {
        name: "Example",
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password' } }
    end
    follow_redirect!
    assert_select "a[href=?]", categories_path
    assert is_signed_in?
  end
end
