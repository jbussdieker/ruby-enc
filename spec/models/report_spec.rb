require 'spec_helper'

describe Report do
  it "has a valid factory" do
    FactoryGirl.create(:report).should be_valid
  end

  context "dependents" do
    before(:each) do
      @report = FactoryGirl.create(:report_with_dependents)
    end

    it "deletes metrics" do
      expect {
        @report.destroy
      }.to change(Metric, :count).by(-5)
    end

    it "deletes report logs" do
      expect {
        @report.destroy
      }.to change(ReportLog, :count).by(-5)
    end

    it "deletes resource statuses" do
      expect {
        @report.destroy
      }.to change(ResourceStatus, :count).by(-5)
    end
  end
end
