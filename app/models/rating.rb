class Rating < ApplicationRecord
  after_save :update_product_rating

  belongs_to :user
  belongs_to :product

  validates :rate, presence: true,
    inclusion: {in: Settings.ratings.min_rate..Settings.ratings.max_rate}

  private
  def update_product_rating
    product = self.product
    average_rate = product.ratings.average :rate
    product.update rating: average_rate
  end
end
