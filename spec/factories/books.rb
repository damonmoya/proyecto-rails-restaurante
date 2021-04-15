FactoryBot.define do
  factory :book do
    email { Faker::Internet.email }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    diners { Faker::Number.between(from: 1, to: 4) }
    state { Faker::Number.between(from: 0, to: 1) }
  end
end
