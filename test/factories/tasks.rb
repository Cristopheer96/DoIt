FactoryBot.define do
  factory :task do
    title { "#{Faker::Verb.ing_form} #{Faker::Lorem.paragraph} " }
    description { Faker::Quote.fortune_cookie }
    state { Faker::Boolean.boolean }
    start_date { "#2022-#{rand(1..12)}-#{rand(1..28)}"} # faker no tenia un formato como este
    end_date { "#2022-#{rand(1..12)}-#{rand(1..28)}" }
    importance { rand(1..5) }
    user  #referencia al factory de user
    after :create do |task|
      create_list :labelled, 3 , task: task             # has_one
    end
  end
end
