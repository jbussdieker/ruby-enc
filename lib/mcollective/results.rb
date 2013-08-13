require 'json'

module Mcollective
  class Results
    include Enumerable

    def initialize(data)
      @data = JSON.parse(data)
    end

    def each(&block)
      return [] unless @data.kind_of? Array
      @data.sort {|a,b| a["sender"] <=> b["sender"]}.each do |item|
        yield(item)
      end
    end

    def collect(&block)
      return nil unless @data.kind_of? Array
      @data.collect {|item| yield(item)}
    end

    def first
      @data.first
    end

    def count
      return 0 unless @data.kind_of? Array
      @data.count
    end

    def error
      @data["error"] if @data.kind_of? Hash
    end

    def pretty
      collect {|v| "   #{v["sender"]} => #{v["statusmsg"]}"}.join("\n")
    end

    def success?
      return false unless @data.kind_of? Array
      @data.each do |item|
        return false unless item["statuscode"] == 0
      end
      true
    end
  end
end

