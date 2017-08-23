module CategoriesHelper

  def task_count(category)
    tasks = []
    category.tasks.each do |task|
      if !task.completed
        tasks << task
      end
    end
    tasks.count
  end

  def total_tasks
    tasks = []
    @user.tasks.each do |task|
      if !task.completed && !task.content.nil?
        tasks << task
      end
    end
    tasks.count
  end

  def overdue_tasks
    tasks = []
    @user.tasks.each do |task|
      if task.overdue?
        tasks << task
      end
    end
    tasks.count
  end

  def week_tasks
    tasks = []
    @user.tasks.each do |task|
      if task.week?
        tasks << task
      end
    end
    tasks.count
  end

  def today_tasks
    tasks = []
    @user.tasks.each do |task|
      if task.today?
        tasks << task
      end
    end
    tasks.count
  end

  def completed_tasks(category)
    tasks = []
    category.tasks.each do |task|
      if task.completed
        tasks << task
      end
    end
    tasks.count
  end
end
