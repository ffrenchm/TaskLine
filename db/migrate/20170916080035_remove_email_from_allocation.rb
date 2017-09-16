class RemoveEmailFromAllocation < ActiveRecord::Migration[5.0]
  def change
    remove_column :allocations, :email, :string
    add_column :allocations, :team_id, :integer
  end
end
