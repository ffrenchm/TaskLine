class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :deadline_date
      t.datetime :deadline_time
      t.integer :repeat
      t.boolean :completed, default: false
      t.string :content
      t.text :notes

      t.timestamps
    end
  end
end
