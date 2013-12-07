RSpec.configure do |config|
  config.include Capybara::DSL
  
  Capybara.run_server = true
  Capybara.server_port = 3000
  Capybara.app_host = 'http://localhost:3000'
  Capybara.default_wait_time = 5

  Capybara.register_driver :chrome do |app|
    args = []
    args << "--window-size=1280,1024"
    Capybara::Selenium::Driver.new(app, :browser => :chrome, :args => args)
  end

  Capybara.javascript_driver = :chrome
  Capybara.default_driver = :chrome
end
