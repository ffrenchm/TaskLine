class AddNotesToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :notes, :text
  end
end
