class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  default_scope -> { order(:deadline_date) }
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 155}

  def overdue?
    !self.completed && self.deadline_date && self.deadline_date < Time.now
  end

  def today?
    (!self.completed && self.deadline_date && self.deadline_date.today?)
  end

  def week?
    (!self.completed && self.deadline_date && self.deadline_date - Time.now < 7.days)
  end

  def increment
    n = self.repeat_number
    case self.repeat_period
    when "Day"
      n.days
    when "Week"
      n.weeks
    when "Month"
      n.months
    when "Year"
      n.years
    else
      0
    end
  end

  def repeat_message
    if self.repeat_number == 1
      " - Every " + self.repeat_period
    else
      " - Every " + self.repeat_number.to_s + " " + self.repeat_period + "s"
    end
  end

end
