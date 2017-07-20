FactoryGirl.define do
  factory :node do
    name { Faker::Lorem.word }
  end

  factory :invalid_node, parent: :node do
    name { nil }
  end

  factory :unreported_node, parent: :node do
    reported_at { nil }
  end

  factory :responsive_node, parent: :node do
    reported_at { Time.now }
  end

  factory :unresponsive_node, parent: :node do
    reported_at { 30.days.ago }
  end

  factory :node_with_parameters, parent: :node do
    after(:create) do |node|
      create(:parameter, parameterable: node)
    end
  end

  factory :node_with_all_dependents, parent: :node do
    after(:create) do |node|
      create(:parameter, parameterable: node)
      create(:report_with_dependents, node: node)
      node_class = create(:node_class)
      create(:node_class_membership, node_class: node_class, node: node)
      node_group = create(:node_group_with_parameters)
      create(:node_group_membership, node_group: node_group, node: node)
    end
  end

  factory :node_with_reports, parent: :node do
    ransient do
      report_count 5
    end

    after(:create) do |node, evaluator|
      create_list(:report_with_dependents, evaluator.report_count, node: node)
    end
  end

  factory :changed_node, parent: :responsive_node do
    status { "changed" }
  end

  factory :failed_node, parent: :responsive_node do
    status { "failed" }
  end

  factory :unchanged_node, parent: :responsive_node do
    status { "unchanged" }
  end

  factory :pending_node, parent: :responsive_node do
    status { "pending" }
  end
end
