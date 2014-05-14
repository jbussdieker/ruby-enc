FactoryGirl.define do
  factory :parameter do
    key { Faker::Lorem.word }
    value { Faker::Lorem.word }
  end

  factory :invalid_parameter, parent: :parameter do
    value { nil }
  end
end
