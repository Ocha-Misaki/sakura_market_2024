class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :foods, through: :cart_items

  def subtotal
    cart_items.sum(&:price_including_tax).floor
  end

  def total_price_including_tax
    self.subtotal + ((self.cash_on_delivery_fee + self.shipping_fee) * Food::TAX_RATE)
  end

  def cash_on_delivery_fee
    case self.subtotal
    when 0...10000
      300
    when 10000...30000
      400
    when 30000...100000
      600
    else
      1000
    end
  end

  def total_cart_items_quantity
    cart_items.sum(&:quantity)
  end

  def shipping_fee
    unit_of_item = (self.total_cart_items_quantity / 5).ceil
    additional_fee = unit_of_item * 600
    600 + additional_fee
  end

  def orderable?
    cart_items.present? && cart_items.all?(&:orderable?)
  end
end
