require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:matt)
    @list_category = list_categories(:work)
  end

  test "profile display" do
    sign_in_as(@user)
    get list_categories_path
    assert_match @user.list_categories.count.to_s, response.body
  end

  test "list category interface" do
    sign_in_as(@user)
    get list_categories_path
    # invalid creation of category
    assert_no_difference 'ListCategory.count' do
      post list_categories_path, params: { list_category: {title: "" } }
    end
    # valid creation of category
    assert_difference 'ListCategory.count', 1 do
      post list_categories_path, params: { list_category: { title: "Test" } }
    end
    assert_redirected_to list_categories_path
    follow_redirect!
    # delete category
    assert_select 'a', text: 'Delete'
    assert_difference 'ListCategory.count', -1 do
      delete list_category_path(@list_category)
    end
  end

end
