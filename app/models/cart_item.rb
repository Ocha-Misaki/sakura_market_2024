class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  validates :quantity, presence: true
  scope :adding_order, -> { order(:food_id) }

  def price_including_tax
    (food.price * quantity * Food::TAX_RATE).floor
  end

  def orderable?
    food.displayable?
  end
end
