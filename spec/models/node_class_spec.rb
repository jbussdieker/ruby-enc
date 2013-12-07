require 'spec_helper'

describe NodeClass do
  it "has a valid factory" do
    FactoryGirl.create(:node_class).should be_valid
  end

  it "orders by ascending name" do
    class_one = FactoryGirl.create(:node_class, name: "foo")
    class_two = FactoryGirl.create(:node_class, name: "bar")
    NodeClass.all.should eq [class_two, class_one]
  end

  it "does not allow duplicate names" do
    node_class = FactoryGirl.create(:node_class)
    FactoryGirl.build(:node_class, name: node_class.name).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:node_class, name: nil).should_not be_valid
  end

  it "returns name for to_param" do
    node_class = FactoryGirl.create(:node_class)
    node_class.to_param.should == node_class.name
  end

  it "returns name for to_s" do
    node_class = FactoryGirl.create(:node_class)
    node_class.to_s.should == node_class.name
  end
end
