class Product < ApplicationRecord
  ATTRIBUTE_PARAMS = [:name, :price, :quantity, :picture, :category_id, :description]

  enum status: {available: 1, not_available: 0}

  belongs_to :category

  has_many :order_products
  has_many :comments
  has_many :ratings
  has_many :orders, through: :order_products

  scope :order_desc, ->{order created_at: :desc}
  scope :in_classify, ->(classify){joins(:category)
    .where "classify = ?", Category.classifies[classify] if classify.present?}
  scope :order_rating, ->(rule){order rating: rule if rule.present?}
  scope :price_between, ->(from, to){where "price BETWEEN ? AND ?", from, to if from.present? && to.present?}
  scope :order_price, ->(rule){order price: rule if rule.present?}
  scope :order_name, ->(rule){order name: rule if rule.present?}
  scope :name_like, ->(name){where "products.name LIKE ?", "%#{name}%" if name.present?}
  scope :belongs_to_category, ->(category_id){where category_id: category_id if category_id.present?}

  mount_uploader :picture, PictureUploader

  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality:
    {greater_than_or_equal_to: 0}
  validate :picture_size
  validates :picture, presence: true, on: :create

  after_update :update_child

  def not_rated? user
    return self.ratings.find_by(user: user) ? false : true
  end

  private
  def picture_size
    errors.add :picture, I18n.t("picture.error_picture_size") if
      picture.size > 5.megabytes
  end

  def update_child
    self.comments.update_all status: "not_available"
    self.ratings.update_all status: "not_available"
  end
end
