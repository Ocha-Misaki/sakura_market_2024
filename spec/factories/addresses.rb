FactoryBot.define do
  factory :address do
    user
    address_name { 'テスト太郎' }
    location { '東京都大田区田園調布' }
  end
end
