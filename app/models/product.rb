class Product < ApplicationRecord
  enum status: {available: 1, not_available: 0}

  belongs_to :category

  has_many :order_products
  has_many :product_images
  has_many :comments
  has_many :ratings
  has_many :orders, through: :order_products

  scope :order_desc, ->{order created_at: :desc}
end
