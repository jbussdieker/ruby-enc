require 'spec_helper'

describe NodeClassMembership do
  it "has a valid factory" do
    FactoryGirl.create(:node_class_membership).should be_valid
  end
end
