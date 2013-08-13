module PuppetDB
  class Client
    def initialize(options = nil)
      @options = options || PuppetDB.options
    end

    def request(path)
      client = Net::HTTP.new(@options[:host], @options[:port])
      request = Net::HTTP::Get.new(path)
      request["Accept"] = "application/json"
      response = client.request(request)
      JSON.parse(response.body)
    end
  end
end
