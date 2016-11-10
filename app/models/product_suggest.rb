class ProductSuggest < ApplicationRecord
  belongs_to :user

  scope :order_desc, ->{order created_at: :desc}

  validates :name, presence: true
  validates :description, presence: true
end
