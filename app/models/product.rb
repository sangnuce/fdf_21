class Product < ApplicationRecord
  belongs_to :category

  has_many :order_products
  has_many :product_images
  has_many :comments
  has_many :ratings
  has_many :orders, through: :order_products
end
