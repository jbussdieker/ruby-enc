FactoryGirl.define do
  factory :report do
  end

  factory :full_report, parent: :report do
    status 'changed'
    environment 'production'
    time { Time.now }
  end

  factory :report_with_dependents, parent: :full_report do
    ransient do
      metric_count 5
      report_log_count 5
      resource_status_count 5
    end

    after(:create) do |report, evaluator|
      create_list(:time_metric, evaluator.metric_count, report: report)
      create_list(:fake_report_log, evaluator.report_log_count, report: report)
      create_list(:fake_resource_status, evaluator.resource_status_count, report: report)
    end
  end
end
