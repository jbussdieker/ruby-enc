require 'sidekiq/testing'
Sidekiq::Testing.fake!

# Not sure if we need test level control but here's the start of it
RSpec.configure do |config|
  config.before :each do
  end
end
