class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :foods, through: :cart_items

  def total_price_including_tax
    cart_items.sum(&:price_including_tax).floor
  end

  def orderable?
    cart_items.all?(&:orderable?)
  end
end
