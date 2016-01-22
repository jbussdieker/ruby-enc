require 'salt/api'

Salt::Api.configure do |config|
  config.hostname = "salt"
  config.username = "salt"
  config.password = "password"
end
