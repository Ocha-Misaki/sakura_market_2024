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

    trait :attach_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/cherry.jpg'), 'image/jpg') }
    end
  end
end
