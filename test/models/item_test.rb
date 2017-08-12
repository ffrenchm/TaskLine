require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @category = categories(:work)
    @item = @category.items.build(content: "Test")
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "list category id should be present" do
    @item.category_id = nil
    assert_not @item.valid?
  end

  test "content should be present" do
    @item.content = "      "
    assert_not @item.valid?
  end

  test "content shouldn't be too long" do
    @item.content = "a"*156
    assert_not @item.valid?
  end
end
