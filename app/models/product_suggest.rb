class ProductSuggest < ApplicationRecord
  belongs_to :user

  enum status: {accept: 1, not_accept: 0}

  scope :order_desc, ->{order created_at: :desc}

  validates :name, presence: true
  validates :description, presence: true
end
