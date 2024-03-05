class Food < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :position, numericality: { only_integer: true }
  scope :custom_order, -> { order(:position) }
  scope :displayable, -> { where(displayable: true) }
  acts_as_list

  TAX_RATE = 1.10

  def price_including_tax
    (price * TAX_RATE).floor
  end
end
