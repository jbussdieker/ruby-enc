FactoryGirl.define do
  factory :report_log do
  end

  factory :fake_report_log, parent: :report_log do
    time { Time.now }
    level { Faker::Lorem.word }
    message { Faker::Lorem.word }
    source { Faker::Lorem.word }
  end
end
