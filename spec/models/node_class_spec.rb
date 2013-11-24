require 'spec_helper'

describe NodeClass do
  it "has a valid factory" do
    FactoryGirl.create(:node_class).should be_valid
  end
end
