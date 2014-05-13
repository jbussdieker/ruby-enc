FactoryGirl.define do
  factory :metric do
    association :report
  end

  factory :time_metric, parent: :metric do
    category { "Time" }
    name { Faker::Lorem.word }
    value { Faker::Number.digit }
  end
end
