FactoryBot.define do
  factory :user do
    email { 'test@email.com' }
    password { 'foobaruser' }
    password_confirmation { 'foobaruser' }
    confirmed_at { Time.now }
  end

  trait :other_user do
    email { 'other@email.com' }
    password { 'foobarother' }
    password_confirmation { 'foobarother' }
    confirmed_at { Time.now }
  end
end
