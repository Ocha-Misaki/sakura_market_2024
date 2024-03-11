module OrdersHelper
  def delivery_at_text(order)
    "#{l order.delivery_on} #{order.delivery_time}"
  end

  def order_item_quantity_text(order)
    "#{order.order_item_quantity}個"
  end
end
