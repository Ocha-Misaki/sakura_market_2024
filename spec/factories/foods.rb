FactoryBot.define do
  factory :food do
    name { 'にんじん' }
    price { 100 }
    description { '美味しい' }
    position { 1 }
    displayable { false }

    trait :displayable do
      displayable { true }
    end
  end
end
