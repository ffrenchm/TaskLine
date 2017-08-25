class AddColumnsToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :repeat_number, :integer
    add_column :tasks, :repeat_period, :string
  end
end
