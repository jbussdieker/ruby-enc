require 'puppetdb/client'

module PuppetDB
  module Node
    def facts
      @facts ||= Client.new.request("/v2/nodes/#{name}/facts")
    end

    def resources
      @resource ||= Client.new.request("/v2/nodes/#{name}/resources")
    end

    def resource_types
      resources.collect {|r| r["type"]}.uniq
    end
  end
end
