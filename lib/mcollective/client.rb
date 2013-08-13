require 'net/http'
require 'cgi'

module Mcollective
  class Client
    def initialize
      @config = Mcollective.config
    end

    def run(agent, action, options={}, args={})
      raise "Invalid Agent (#{agent})" unless agent and !agent.empty?
      raise "Invalid Action (#{action})" unless action and !action.empty?

      timeout = 15
      options[:timeout].to_s.scan(/\d+/) {|v| timeout = v.to_i}
      options[:timeout] = timeout

      src = "http://#{@config[:host]}:#{@config[:port]}/#{agent}/#{action}.json?"
      src += "options=#{CGI.escape options.to_json}&args=#{CGI.escape args.to_json}"
      url = URI.parse(src)

      req = Net::HTTP::Get.new(url.request_uri)

      http = Net::HTTP.new(url.host, url.port)

      http.read_timeout = timeout
      http.open_timeout = 2

      resp = http.request(req)
      raise resp.inspect unless resp.kind_of? Net::HTTPSuccess

      return Results.new(resp.body)
    end
  end
end
