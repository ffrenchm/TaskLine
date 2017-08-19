require 'test_helper'

class ItemsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @category = categories(:chores)
    @item = items(:cook)
  end

  test "item interface" do
    sign_in_as(@user)
    get categories_path
    # invalid creation of category
    assert_no_difference 'Item.count' do
      post category_items_path(@category), params: { item: { content: "" } }
    end
    # valid creation of category
    assert_difference 'Item.count', 1 do
      post category_items_path(@category), params: { item: { content: "Test" } }
    end
    assert_redirected_to categories_path
    # check for presence of show and destroy links
    follow_redirect!
    assert_select "a[href=?]", category_item_path(@category, @item), method: :delete
    # delete category
    assert_difference 'Item.count', -1 do
      delete category_item_path(@category, @item)
    end
  end
end
