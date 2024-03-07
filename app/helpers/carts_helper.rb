module CartsHelper
  def total_price_including_tax_text
    number_to_currency(current_cart.total_price_including_tax).to_s
  end

  def purchase_button
    if current_cart&.cart_items&.empty? || !current_cart&.orderable?
      button_tag '注文する', class: 'btn btn-outline-danger disabled'
    else
      button_to '注文する', '#', method: :post, class: 'btn btn-outline-danger', data: { turbo_confirm: '注文してよろしいですか？' }
    end
  end

  def total_cart_items_quantity_text
    "#{current_cart.cart_items.sum(&:quantity)}個"
  end
end
