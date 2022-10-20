FactoryBot.define do
  factory :product do
    product_name { Faker::Name.name }
    cost { Faker::Number.within(range: 1..100) * 5 }
    amount_available { Faker::Number.within(range: 1..50) }
    association :seller
  end
end