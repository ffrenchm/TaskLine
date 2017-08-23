require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup
    @user = users(:matt)
    @category = @user.categories.find_by(title: "work")
    @task = @category.tasks.build(content: "Test", repeat: 0, user_id: @user.id)
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "category id should be present" do
    @task.category_id = nil
    assert_not @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "content should be present" do
    @task.content = "      "
    assert_not @task.valid?
  end

  test "content shouldn't be too long" do
    @task.content = "a" * 156
    assert_not @task.valid?
  end
end
