require 'spec_helper'

describe Node do
  it "has a valid factory" do
    FactoryGirl.create(:node).should be_valid
  end
end
