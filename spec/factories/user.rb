FactoryBot.define do
  factory :buyer, class: User do
    user_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email}
    password { 'password' }
    password_confirmation { 'password' }
    role { 0 }
  end

  factory :seller, class: User do
    user_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'seller123' }
    password_confirmation { 'seller123' }
    role { 1 }
  end
end