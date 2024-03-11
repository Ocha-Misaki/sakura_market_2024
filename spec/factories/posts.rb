FactoryBot.define do
  factory :post do
    user
    title { '美味しいです' }
    text { '美味しいのでおすすめです' }

    trait :attach_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/cherry.jpg'), 'image/jpg') }
    end

    trait :other_post do
      title { '最高です' }
      text { '美味しいので最高です' }
      created_at { Time.zone.today }
    end
  end
end
