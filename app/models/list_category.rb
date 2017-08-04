class ListCategory < ApplicationRecord
  belongs_to :user
  default_scope -> { order(:title) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
end
