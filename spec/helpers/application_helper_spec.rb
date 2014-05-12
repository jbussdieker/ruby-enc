require 'spec_helper'

describe ApplicationHelper do
  describe "sortable" do
    let(:column) { "name" }
    let(:title) { "Name" }
    subject { helper.sortable(column, title) }
    before { helper.stub(:sort_column).and_return("uhhh") }
    before { helper.stub(:sort_direction).and_return("asc") }
    before { helper.stub(:link_to) }

    context "not already sorted" do
      before { helper.stub(:sort_column).and_return(nil) }
      before { helper.stub(:sort_direction).and_return("asc") }

      it "should call link_to" do
        helper.should_receive(:link_to).with(title, {:sort => column, :direction => "asc" }, { :class => nil })
        subject
      end
    end

    context "already sorted asc" do
      before { helper.stub(:sort_column).and_return(column) }
      before { helper.stub(:sort_direction).and_return("asc") }

      it "should call link_to" do
        helper.should_receive(:link_to).with(title, {:sort => column, :direction => "desc" }, { :class => "current asc" })
        subject
      end
    end
  end

  describe "link_to_remove_fields" do
    let(:name) { "name" }
    let(:builder) { double }
    let(:f) { builder }
    subject { helper.link_to_remove_fields(name, f) }
    before { builder.stub(:hidden_field).and_return("a") }
    before { helper.stub(:link_to_function).and_return("b") }

    it { should == "ab" }
  end

  describe "link_to_add_fields" do
    let(:name) { "Add Parameter" }
    let(:node) { FactoryGirl.create(:node) }
    let(:builder) { double }
    let(:f) { builder }
    let(:association) { :parameters }
    subject { helper.link_to_add_fields(name, f, association) }
    before { builder.stub(:object).and_return(node) }
    before { builder.stub(:fields_for).and_return("") }

    it { should =~ /#{name}/ }
  end
end
