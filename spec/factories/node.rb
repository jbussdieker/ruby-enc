FactoryGirl.define do
  factory :node do
    name { Faker::Lorem.word }
  end
end
