class CreateAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :allocations do |t|
      t.string :email
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :task_id

      t.timestamps
    end
  end
end
