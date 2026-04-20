FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    role { :admin }
  end
end