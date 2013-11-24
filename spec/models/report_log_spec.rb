require 'spec_helper'

describe ReportLog do
  it "has a valid factory" do
    FactoryGirl.create(:report_log).should be_valid
  end
end
