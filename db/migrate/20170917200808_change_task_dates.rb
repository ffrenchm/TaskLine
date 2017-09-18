class ChangeTaskDates < ActiveRecord::Migration[5.0]
  def change
    change_table :tasks do |t|
      t.change :deadline_date, :date
      t.change :deadline_time, :time
    end
  end
end
