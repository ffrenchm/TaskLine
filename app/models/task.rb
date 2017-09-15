class Task < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :team, optional: true
  belongs_to :user
  has_many :allocations

  default_scope -> { order(:deadline_date) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 155}

  def overdue?
    d = self.deadline_date
    t = self.deadline_time
    (!self.completed && d && !t && d < Time.now) || (d && t && !self.completed && (d + t.seconds_since_midnight.seconds).to_datetime < Time.now)
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
    when "Days"
      n.days
    when "Weeks"
      n.weeks
    when "Months"
      n.months
    when "Years"
      n.years
    else
      0
    end
  end

  def repeat_message
    if self.repeat_number == 1
      " - Every " + self.repeat_period.to_s.chop
    else
      " - Every " + self.repeat_number.to_s + " " + self.repeat_period
    end
  end

end
