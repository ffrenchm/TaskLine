module CategoriesHelper

  def item_count(category)
    items = []
    category.items.each do |item|
      if item.completed == false
        items << item
      end
    end
    pluralize(items.count, "task") + " outstanding"
  end
end
