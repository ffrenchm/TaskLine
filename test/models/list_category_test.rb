require 'test_helper'

class ListCategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @list_category = @user.list_categories.build(title: "Test")
  end

  test "should be valid" do
    assert @list_category.valid?
  end

  test "user id should be present" do
    @list_category.user_id = nil
    assert_not @list_category.valid?
  end

  test "title should be present" do
    @list_category.title = "    "
    assert_not @list_category.valid?
  end

  test "title should be at most 50 characters" do
    @list_category.title = "a" * 51
    assert_not @list_category.valid?
  end

  test "order should be alphabetical" do
    assert_equal list_categories(:admin), ListCategory.first
  end
end
