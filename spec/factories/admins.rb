FactoryBot.define do
  factory :admin do
    email { 'admin@example.com' }
    password { 'adminsonic' }
    password_confirmation { 'adminsonic' }
  end
end
