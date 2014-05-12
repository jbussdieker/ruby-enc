require 'spec_helper.rb'

describe ReportCleaning do
  before do
    FactoryGirl.create(:report_with_dependents, created_at: 30.days.ago)
    FactoryGirl.create(:report_with_dependents, created_at: Time.now)
  end

  context "clean" do
    subject { ReportCleaning.new(7.days.ago).clean }

    it "should return the deleted items" do
      subject.count.should == 1
    end

    it "should remove reports" do
      expect {
        subject
      }.to change(Report, :count).by(-1)
    end

    it "should remove report logs" do
      expect {
        subject
      }.to change(ReportLog, :count).by(-5)
    end

    it "should remove metrics" do
      expect {
        subject
      }.to change(Metric, :count).by(-5)
    end

    it "should remove resource statuses" do
      expect {
        subject
      }.to change(ResourceStatus, :count).by(-5)
    end
  end
end
