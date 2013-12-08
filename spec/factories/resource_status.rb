FactoryGirl.define do
  factory :resource_status do
  end

  factory :fake_resource_status, parent: :resource_status do
    title { Faker::Lorem.word }
    is_changed { Faker::Number.digit.to_i % 2 == 1 }
    skipped { Faker::Number.digit.to_i % 2 == 1 }
    failed { Faker::Number.digit.to_i % 2 == 1 }
  end
end
