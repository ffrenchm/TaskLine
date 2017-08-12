class RemoveListCategoryFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_reference :items, :list_category, foreign_key: true
  end
end
