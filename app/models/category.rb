class Category < ApplicationRecord
  enum classify: {food: 0, drink: 1}

  has_many :products, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :classify, presence: true, inclusion: {in: classifies}

  scope :name_like, ->(name){where "name LIKE ?", "%#{name}%"}

  after_destroy :update_child

  def load_products number
    products.available.order_desc.take number
  end

  private
  def update_child
    Product.available.belongs_to_no_category.update_all status: "not_available"
  end
end
