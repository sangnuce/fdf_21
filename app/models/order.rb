class Order < ApplicationRecord
  belongs_to :user

  enum status: {pending: 0, approved: 1, cancelled: 2}

  has_many :order_products
  has_many :products, through: :order_products

  scope :order_desc, ->{order created_at: :desc}
  scope :phone_like, ->(phone){where "receiver_phone == ?", phone}

  validates :receiver_name, presence: true
  validates :receiver_address, presence: true
  validates :receiver_phone, presence: true
  validates :delivery_time, presence: true

  validate :delivery_time_cannot_be_in_the_past

  accepts_nested_attributes_for :order_products

  private
  def delivery_time_cannot_be_in_the_past
    if delivery_time.present? && delivery_time < Time.zone.now
      errors.add :delivery_time, I18n.t("orders.cant_be_in_the_past")

  def send_new_order_email
    @users = User.admin
    @users.each do |user|
      UserMailer.new_order(user, self).deliver_now
    end
  end
end
