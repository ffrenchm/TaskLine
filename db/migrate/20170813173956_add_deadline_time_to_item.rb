class AddDeadlineTimeToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :deadline_time, :datetime
  end
end
