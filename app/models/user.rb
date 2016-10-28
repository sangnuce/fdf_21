class User < ApplicationRecord
  has_many :orders
  has_many :product_suggests, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
end
