require 'spec_helper'

describe ResourceStatus do
  it "has a valid factory" do
    FactoryGirl.create(:resource_status).should be_valid
  end
end
