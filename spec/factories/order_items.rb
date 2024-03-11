FactoryBot.define do
  factory :order_item do
    food
    order
    food_name { food.name }
    food_price { food.price }
    food_quantity { 3 }
  end
end
