require 'puppetdb'

Enc.config.tap do |config|
  PuppetDB.configure(
    host: config.puppetdb_host,
    port: config.puppetdb_port,
  )
end
