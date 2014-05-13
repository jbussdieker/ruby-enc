FactoryGirl.define do
  factory :node_class do
    name { Faker::Lorem.word }
  end

  factory :invalid_node_class, parent: :node_class do
    name { nil }
  end
end
