require 'spec_helper'

describe PuppetDB::Client do
  let(:options) { {} }
  let(:client) { PuppetDB::Client.new(options) }
  subject { client }

  describe 'client' do
    subject { client.client }

    it { should be_kind_of Net::HTTP }
  end
end
