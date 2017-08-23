module CategoriesHelper

  def item_count(category)
    items = []
    category.items.each do |item|
      if !item.completed
        items << item
      end
    end
    items.count
  end

  def total_items
    items = []
    @user.items.each do |item|
      if !item.completed && !item.content.nil?
        items << item
      end
    end
    items.count
  end

  def overdue_items
    items = []
    @user.items.each do |item|
      if item.overdue?
        items << item
      end
    end
    items.count
  end

  def week_items
    items = []
    @user.items.each do |item|
      if item.week?
        items << item
      end
    end
    items.count
  end

  def today_items
    items = []
    @user.items.each do |item|
      if item.today?
        items << item
      end
    end
    items.count
  end

  def completed_items(category)
    items = []
    category.items.each do |item|
      if item.completed
        items << item
      end
    end
    items.count
  end
end
