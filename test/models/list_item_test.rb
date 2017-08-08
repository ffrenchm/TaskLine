require 'test_helper'

class ListItemTest < ActiveSupport::TestCase

  def setup
    @list_category = list_categories(:work)
    @list_item = @list_category.list_items.build(content: "Test")
  end

  test "should be valid" do
    assert @list_item.valid?
  end

  test "list category id should be present" do
    @list_item.list_category_id = nil
    assert_not @list_item.valid?
  end

  test "content should be present" do
    @list_item.content = "      "
    assert_not @list_item.valid?
  end

  test "content shouldn't be too long" do
    @list_item.content = "a"*156
    assert_not @list_item.valid?
  end
end
