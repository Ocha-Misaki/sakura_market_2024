module CartsHelper
  def subtotal_text
    number_to_currency(current_cart.subtotal).to_s
  end

  def total_price_including_tax_text
    number_to_currency(current_cart.total_price_including_tax).to_s
  end

  def purchase_button
    if current_cart&.cart_items&.empty? || !current_cart&.orderable?
      button_tag 'レジに進む', class: 'btn btn-outline-danger disabled'
    else
      link_to 'レジに進む', new_order_path, class: 'btn btn-outline-danger'
    end
  end

  def total_cart_items_quantity_text
    "#{current_cart.total_cart_items_quantity}個"
  end

  def shipping_fee_text
    number_to_currency(current_cart.shipping_fee).to_s
  end

  def cash_on_delivery_fee_text
    number_to_currency(current_cart.cash_on_delivery_fee).to_s
  end
end
