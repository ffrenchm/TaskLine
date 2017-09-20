class AddIndexToTasks < ActiveRecord::Migration[5.0]
  def change
    add_index :tasks, :deadline_date
    add_index :tasks, :completed
  end
end
