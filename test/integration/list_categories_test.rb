require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:matt)
  end

  test "profile display" do
    sign_in_as(@user)
    get list_categories_path
    assert_match @user.list_categories.count.to_s, response.body
  end
end
