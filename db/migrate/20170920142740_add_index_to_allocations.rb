class AddIndexToAllocations < ActiveRecord::Migration[5.0]
  def change
    add_index :allocations, :recipient_id
    add_index :allocations, :task_id
    add_index :allocations, :team_id
  end
end
