class ListItem < ApplicationRecord
  belongs_to :list_category
  validates :list_category_id, presence: true
  validates :content, presence: true, length: { maximum: 155}
end
