module FoodsHelper
  def price_including_tax_text(food)
    "#{number_to_currency(food.price_including_tax)}（税込）"
  end

  def displayable_book_status_badge(food)
    label, css = food.displayable ? ['公開中', 'bg-info'] : ['非公開', 'bg-warning']
    tag.span label, class: "badge #{css}", 'data-test-id': dom_id(food, :displayable)
  end
end
