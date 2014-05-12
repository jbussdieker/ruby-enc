require 'spec_helper'

describe NodesHelper do
  describe "node_report_time" do
    subject { helper.node_report_time(time) }

    context "with time" do
      let(:time) { Time.now }
      it { should == "less than a minute ago" }
    end

    context "without time" do
      let(:time) { nil }
      it { should == "unreported" }
    end
  end

  describe "node_status_badge" do
    let(:node) { double }
    subject { helper.node_status_badge(node) }

    context "unreported" do
      before { node.stub(:status).and_return(nil) }
      it { should =~ /unreported/ }
    end

    context "reported" do
      ["changed", "pending", "unchanged", "failed"].each do |status|
        context status do
          before { node.stub(:status).and_return(status) }
          it { should =~ /#{status}/ }
        end
      end

      context "unknown status" do
        before { node.stub(:status).and_return(Random.rand) }
        it { should == nil }
      end
    end
  end
end
