FactoryGirl.define do
  factory :node_group do
    name { Faker::Lorem.word }
  end

  factory :node_group_with_parameters, parent: :node_group do
    after(:create) do |node_group|
      create(:parameter, parameterable: node_group)
    end
  end
end
