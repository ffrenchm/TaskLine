require 'test_helper'

class CategoriesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:matt)
    @category = categories(:work)
  end

  test "profile display" do
    sign_in_as(@user)
    get categories_path
    assert_match @user.categories.count.to_s, response.body
  end

  test "list category interface" do
    sign_in_as(@user)
    get categories_path
    # invalid creation of category
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {title: "" } }
    end
    # valid creation of category
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { title: "Test" } }
    end
    assert_redirected_to categories_path
    # check for presence of show and destroy links
    follow_redirect!
    assert_select "a[href=?]", category_path(@category), method: :delete
    assert_select "a[href=?]", category_path(@category)
    # delete category
    assert_difference 'Category.count', -1 do
      delete category_path(@category)
    end
  end

end
