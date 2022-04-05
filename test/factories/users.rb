FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    passowrd { Faker::Internet.password }
  end
end
