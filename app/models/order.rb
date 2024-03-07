class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :foods, through: :order_items
  validates :order_name, presence: true
  validates :order_address, presence: true
  validates :delivery_at, presence: true
  validates :shipping_fee, presence: true, numericality: { greater_than_or_equal_to: 600 }
  validates :cash_on_delivery_fee, presence: true, numericality: { greater_than_or_equal_to: 300 }
  scope :default_order, -> { order(id: :desc) }

  def create_order_from_cart(cart)
    return false unless cart.orderable?

    transaction do
      cart.cart_items.each do |cart_item|
        order_items.build(
          food: cart_item.food,
          food_name: cart_item.food.title,
          food_price: cart_item.food.price_including_tax,
          food_quantity: cart_item.quantity
        )
        save!
      end
      cart.cart_items.destroy_all
    end
  end

  def total_price_including_tax
    ((books.sum(&:price) * Book::TAX_RATE) + shipping_fee + cash_on_delivery_fee).floor
  end
end
