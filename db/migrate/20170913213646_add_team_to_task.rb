class AddTeamToTask < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :team, foreign_key: true
  end
end
