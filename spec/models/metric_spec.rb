require 'spec_helper'

describe Metric do
  it "has a valid factory" do
    FactoryGirl.create(:metric).should be_valid
  end
end
