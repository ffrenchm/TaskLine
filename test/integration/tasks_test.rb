require 'test_helper'

class TasksTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:matt)
    @category = categories(:chores)
    @task = tasks(:cook)
  end

  test "task interface" do
    sign_in_as(@user)
    get categories_path
    # invalid creation of category
    assert_no_difference 'Task.count' do
      post category_tasks_path(@category), params: { task: { content: "" } }
    end
    # valid creation of category
    assert_difference 'Task.count', 1 do
      post category_tasks_path(@category), params: { task: { content: "Test" } }
    end
    assert_redirected_to categories_path
    # check for presence of show and destroy links
    follow_redirect!
    assert_select "a[href=?]", category_task_path(@category, @task), method: :delete
    # delete category
    assert_difference 'Task.count', -1 do
      delete category_task_path(@category, @task)
    end
  end
end
