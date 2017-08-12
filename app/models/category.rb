class Category < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  default_scope -> { order(:title) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
end
