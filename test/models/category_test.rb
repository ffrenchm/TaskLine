require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @category = @user.categories.build(title: "Test")
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "user id should be present" do
    @category.user_id = nil
    assert_not @category.valid?
  end

  test "title should be present" do
    @category.title = "    "
    assert_not @category.valid?
  end

  test "title should be at most 50 characters" do
    @category.title = "a" * 51
    assert_not @category.valid?
  end

  test "order should be alphabetical" do
    assert_equal categories(:admin), Category.first
  end
end
