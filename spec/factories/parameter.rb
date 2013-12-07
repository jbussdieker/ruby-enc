FactoryGirl.define do
  factory :parameter do
    key { Faker::Lorem.word }
    value { Faker::Lorem.word }
  end
end
