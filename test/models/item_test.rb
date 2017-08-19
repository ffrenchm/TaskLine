require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @user = users(:matt)
    @category = @user.categories.find_by(title: "work")
    @item = @category.items.build(content: "Test", repeat: 0, user_id: @user.id)
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "category id should be present" do
    @item.category_id = nil
    assert_not @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end

  test "content should be present" do
    @item.content = "      "
    assert_not @item.valid?
  end

  test "content shouldn't be too long" do
    @item.content = "a" * 156
    assert_not @item.valid?
  end
end
