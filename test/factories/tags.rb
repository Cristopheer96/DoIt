FactoryBot.define do
  factory :tag do
    title { Faker::Verb.simple_present }
    color {Faker::Color.color_name}
    user
  end
end
