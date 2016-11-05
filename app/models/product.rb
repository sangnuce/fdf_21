class Product < ApplicationRecord
  ATTRIBUTE_PARAMS = [:name, :price, :quantity, :picture, :category_id]

  enum status: {available: 1, not_available: 0}

  belongs_to :category

  has_many :order_products
  has_many :comments
  has_many :ratings
  has_many :orders, through: :order_products

  scope :order_desc, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality:
    {greater_than_or_equal_to: 0}
  validate :picture_size
  validates :picture, presence: true

  private
  def picture_size
    errors.add :picture, I18n.t("picture.error_picture_size") if
      picture.size > 5.megabytes
  end
end
