require 'net/http'

module PuppetDB
  class Client
    def initialize(options = nil)
      @options = options || PuppetDB.options
    end

    def client
      Net::HTTP.new(@options[:host], @options[:port])
    end

    def build_json_request(path)
      Net::HTTP::Get.new(path).tap do |request|
        request["Accept"] = "application/json"
      end
    end

    def request(path)
      request = build_json_request(path)
      response = client.request(request)
      JSON.parse(response.body)
    end
  end
end
