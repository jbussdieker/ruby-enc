require 'puppetdb/client'

module PuppetDB
  module Facts
    def facts
      Client.new.request("/v2/nodes/#{name}/facts")
    end
  end
end
