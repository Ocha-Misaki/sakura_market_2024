FactoryBot.define do
  factory :cart_item do
    cart
    food
    quantity { 1 }
  end
end
