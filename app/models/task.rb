class Task < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :team, optional: true
  belongs_to :user
  has_many :allocations, dependent: :destroy

  default_scope -> { order(:deadline_date) }
  scope :due_on, -> (date) { where('deadline_date = ?', date) }
  scope :due_before, -> (date) { where('deadline_date < ?', date) }
  scope :complete, -> { where(completed: true) }
  scope :active, -> { where(completed: false) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 155}

  def overdue?
    self.deadline_date && self.deadline_date < Date.today && !self.completed
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
