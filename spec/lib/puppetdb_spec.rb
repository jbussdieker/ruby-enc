require 'spec_helper'

describe PuppetDB do
  its(:options) { should be_kind_of Hash }
end
