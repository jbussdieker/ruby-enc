require 'spec_helper'

describe NodeGroup do
  it "has a valid factory" do
    FactoryGirl.create(:node_group).should be_valid
  end
end
