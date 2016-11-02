class Category < ApplicationRecord
  enum classify: {food: 0, drink: 1}

  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :classify, presence: true, inclusion: {in: classifies}

  scope :name_like, ->(name){where "name LIKE ?", "%#{name}%"}

  def load_products number
    products.available.order_desc.take number
  end
end
