require 'test_helper'

class ListCategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @other_user = users(:chris)
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

  test "should redirect index when not signed in" do
    get list_categories_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect destroy for wrong list category" do
    sign_in_as(@user)
    assert_no_difference "ListCategory.count" do
      delete list_category_path(list_categories(:chemeng))
    end
    assert_redirected_to list_categories_path
  end
end
