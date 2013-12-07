FactoryGirl.define do
  factory :node_group do
    name { Faker::Lorem.word }

    factory :node_group_with_parameters do
      after(:create) do |node_group|
        create(:parameter, parameterable: node_group)
      end
    end
  end
end
