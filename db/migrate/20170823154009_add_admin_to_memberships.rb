class AddAdminToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :admin, :boolean, default: false
  end
end
