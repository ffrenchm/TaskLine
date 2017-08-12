class RenameListCategoriesAndListItems < ActiveRecord::Migration[5.0]
  def change
    rename_table :list_categories, :categories
    rename_table :list_items, :items
  end
end
