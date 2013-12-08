FactoryGirl.define do
  factory :metric do
    association :report
  end

  factory :fake_metric, parent: :metric do
    category { Faker::Lorem.word }
    name { Faker::Lorem.word }
    value { Faker::Number.digit }
  end
end
