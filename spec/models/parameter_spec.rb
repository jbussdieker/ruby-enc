require 'spec_helper'

describe Parameter do
  it "has a valid factory" do
    FactoryGirl.create(:parameter).should be_valid
  end
end
