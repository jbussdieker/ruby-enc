require 'spec_helper'

describe NodeGroup do
  it "has a valid factory" do
    FactoryGirl.create(:node_group).should be_valid
  end

  it "orders by ascending name" do
    group_one = FactoryGirl.create(:node_group, name: "foo")
    group_two = FactoryGirl.create(:node_group, name: "bar")
    NodeGroup.all.should eq [group_two, group_one]
  end

  it "does not allow duplicate names" do
    node_group = FactoryGirl.create(:node_group)
    FactoryGirl.build(:node_group, name: node_group.name).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:node_group, name: nil).should_not be_valid
  end

  it "returns name for to_param" do
    node_group = FactoryGirl.create(:node_group)
    node_group.to_param.should == node_group.name
  end

  it "returns name for to_s" do
    node_group = FactoryGirl.create(:node_group)
    node_group.to_s.should == node_group.name
  end
end
