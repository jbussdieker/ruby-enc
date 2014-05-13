require 'spec_helper'

describe Node do
  it "has a valid factory" do
    FactoryGirl.create(:node).should be_valid
  end

  it "does not allow duplicate names" do
    node = FactoryGirl.create(:node)
    FactoryGirl.build(:node, name: node.name).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:node, name: nil).should_not be_valid
  end

  it "returns name for to_param" do
    node = FactoryGirl.create(:node)
    node.to_param.should == node.name
  end

  it "returns name for to_s" do
    node = FactoryGirl.create(:node)
    node.to_s.should == node.name
  end

  context "dependents" do
    before(:each) do
      @node = FactoryGirl.create(:node_with_reports)
    end

    it "deletes reports" do
      expect {
        @node.destroy
      }.to change(Report, :count).by(-5)
    end

    it "deletes report logs" do
      expect {
        @node.destroy
      }.to change(ReportLog, :count).by(-25)
    end

    it "deletes metrics" do
      expect {
        @node.destroy
      }.to change(Metric, :count).by(-25)
    end

    it "deletes resource statuses" do
      expect {
        @node.destroy
      }.to change(ResourceStatus, :count).by(-25)
    end
  end

  describe "environment" do
    subject { node.environment }

    context "when nil" do
      let(:node) { FactoryGirl.create(:node, environment: nil) }
      it { should == "production" }
    end

    context "when stage" do
      let(:node) { FactoryGirl.create(:node, environment: "stage") }
      it { should == "stage" }
    end
  end

  describe "to_yaml" do
    subject { node.to_yaml }

    context "basic node" do
      let(:node) { FactoryGirl.create(:node, name: "example.com") }
      let(:result) {
"--- 
  classes: []
  name: example.com
  environment: production
  parameters: {}"
      }
      it { should == result }
    end

    context "normal node" do
      let(:node) { FactoryGirl.create(:node_with_all_dependents, name: "example.com") }

      it { should be_kind_of String }
    end
  end
end
