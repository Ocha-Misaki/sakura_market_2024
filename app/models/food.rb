class Food < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :position, numericality: { only_integer: true }
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
    attachable.variant :thumbnail, resize_to_limit: [200, 200]
  end
  has_many :cart_items, dependent: :destroy
  scope :custom_order, -> { order(:position) }
  scope :displayable, -> { where(displayable: true) }
  acts_as_list

  TAX_RATE = 1.10

  def price_including_tax
    (price * TAX_RATE).floor
  end
end
