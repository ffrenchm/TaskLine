class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  default_scope -> { order(:deadline_date) }
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 155}
end
