class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.references :list_category, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
