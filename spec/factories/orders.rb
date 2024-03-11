FactoryBot.define do
  factory :order do
    user
    order_name { 'テスト太郎' }
    order_address { '東京都大田区田園調布' }
    shipping_fee { 600 }
    cash_on_delivery_fee { 300 }
    delivery_time { '8:00-12:00' }
    delivery_on { '2024-03-29' }
  end
end
