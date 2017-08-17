module CategoriesHelper

  def item_count(category)
    items = []
    category.items.each do |item|
      if !item.completed
        items << item
      end
    end
    pluralize(items.count, "task")
  end

  def total_items
    items = []
    @user.items.each do |item|
      unless item.id.nil?
        if !item.completed && !item.content.nil?
          items << item
        end
      end
    end
    (items.count)
  end

  def overdue_items
    items = []
    @user.items.each do |item|
      if (!item.completed && item.deadline_date &&
          item.deadline_date < Time.now)
        items << item
      end
    end
    (items.count)
  end

  def week_items
    items = []
    @user.items.each do |item|
      if (!item.completed && item.deadline_date &&
         item.deadline_date - Time.now < 7.days)
        items << item
      end
    end
    (items.count)
  end

  def today_items
    items = []
    @user.items.each do |item|
      if (!item.completed && item.deadline_date &&
         item.deadline_date.today?)
        items << item
      end
    end
    (items.count)
  end

  def completed_items(category)
    items = []
    category.items.each do |item|
      if item.completed == true
        items << item
      end
    end
    (items.count)
  end
end
