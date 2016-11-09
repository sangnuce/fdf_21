class Order < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, approved: 1, cancelled: 2}

  has_many :order_products
  has_many :products, through: :order_products

  scope :order_desc, ->{order created_at: :desc}
  scope :phone_like, ->(phone){where "receiver_phone == ?", phone}
end
