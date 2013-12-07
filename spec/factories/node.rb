FactoryGirl.define do
  factory :node do
    name { Faker::Lorem.word }

    factory :node_with_parameters do
      after(:create) do |node|
        create(:parameter, parameterable: node)
      end
    end
  end
end
