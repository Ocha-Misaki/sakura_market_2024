FactoryBot.define do
  factory :comment do
    user
    post
    test { 'いいですね' }
  end
end
