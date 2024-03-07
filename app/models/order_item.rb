class OrderItem < ApplicationRecord
  belongs_to :food
  belongs_to :order
  validates :food_name, presence: true
  validates :food_price, presence: true
  validates :food_quantity, presence: true
end
