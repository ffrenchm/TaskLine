require 'test_helper'

class ListCategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @list_category = list_categories(:work)
  end

  test "should redirect create when not signed in" do
    assert_no_difference 'ListCategory.count' do
      post list_categories_path, params: { list_category: { title: "Test" } }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'ListCategory.count' do
      delete list_category_path(@list_category)
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should create list category when signed in" do
    sign_in_as(@user)
    assert_difference 'ListCategory.count', 1 do
      post list_categories_path, params: { list_category: { title: "Test" } }
    end
  end

  test "should destroy list category when signed in" do
    sign_in_as(@user)
    assert_difference 'ListCategory.count', -1 do
      delete list_category_path(@list_category)
    end
  end
end
