class AddColumnsToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :deadline, :datetime
    add_column :items, :repeat, :integer
  end
end
