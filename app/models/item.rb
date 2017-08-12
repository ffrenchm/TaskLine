class Item < ApplicationRecord
  belongs_to :category
  validates :category_id, presence: true
  validates :content, presence: true, length: { maximum: 155}
end
