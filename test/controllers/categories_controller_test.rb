require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @other_user = users(:chris)
    @category = categories(:work)
  end

  test "should redirect create when not signed in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { title: "Test" } }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'Category.count' do
      delete category_path(@category)
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect index when not signed in" do
    get categories_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", signup_path
  end

  test "should redirect destroy for wrong category" do
    sign_in_as(@user)
    assert_no_difference "Category.count" do
      delete category_path(categories(:chemeng))
    end
    assert_redirected_to categories_path
  end
end
