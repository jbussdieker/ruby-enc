require 'puppetdb/client'

module PuppetDB
  module Node
    def facts
      @facts ||= Client.new.request("/v2/nodes/#{name}/facts")
    end

    def resources
      @resource ||= Client.new.request("/v2/nodes/#{name}/resources")
    end

    def deactiveate
      Client.new.request("/v1/commands")
      #curl -XPOST /v1/commands -H "Accept: application/json" -d 'payload={"command":"deactivate node","version":1,"payload":"\"#{name}\""}' -v
    end

    def resource_types
      resources.collect {|r| r["type"]}.uniq
    end
  end
end
