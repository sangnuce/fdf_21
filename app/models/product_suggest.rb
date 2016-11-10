class ProductSuggest < ApplicationRecord
  belongs_to :user

  scope :order_desc, ->{order created_at: :desc}
end
