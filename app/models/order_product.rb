class OrderProduct < ApplicationRecord
  after_save :decrease_product_quantity

  belongs_to :order, optional: true
  belongs_to :product

  validates :quantity, presence: true,
    numericality: {greater_than_or_equal_to: Settings.orders.min_quantity}

  private
  def decrease_product_quantity
    product = self.product
    quantity = product.quantity - self.quantity
    product.update quantity: quantity
  end
end
