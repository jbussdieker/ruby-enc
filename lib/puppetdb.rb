require 'puppetdb/node'

module PuppetDB
  @@options = {}

  def self.configure(options = {})
    @@options = options
  end

  def self.options
    @@options
  end
end
