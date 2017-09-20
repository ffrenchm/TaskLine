class AddIndexToInvites < ActiveRecord::Migration[5.0]
  def change
    add_index :invites, :recipient_id
  end
end
