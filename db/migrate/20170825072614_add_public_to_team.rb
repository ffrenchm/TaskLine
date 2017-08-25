class AddPublicToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :public, :integer
  end
end
