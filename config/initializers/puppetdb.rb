require 'puppetdb'

if ENC_CONFIG[:puppetdb]
  PuppetDB.configure(ENC_CONFIG[:puppetdb])
end
