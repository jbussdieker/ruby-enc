FactoryGirl.define do
  factory :node do
    name { Faker::Lorem.word }

  end

  factory :node_with_parameters, parent: :node do
    after(:create) do |node|
      create(:parameter, parameterable: node)
    end
  end

  factory :node_with_dependents, parent: :node do
    ignore do
      report_count 5
    end

    after(:create) do |node, evaluator|
      FactoryGirl.create_list(:report_with_dependents, evaluator.report_count, node: node)
    end
  end
end
