source 'https://rubygems.org'

gem 'rails', '4.0.6'
gem 'mysql2', '0.3.17'
gem 'syslogger', git: 'https://github.com/jbussdieker/syslogger.git', :branch => 'implement_log_formatter'
gem 'puppet'
gem 'mcollective-client'
gem 'chartkick'
gem 'groupdate'
gem 'rails-bootstrap', '~> 3.0.0'
gem 'kaminari'
gem 'unicorn'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'
gem 'awesome_print', require:"ap"

# attr_accessible` is extracted out of Rails into a gem.
# Please use new recommended protection model for params(strong_parameters)
# or add `protected_attributes` to your Gemfile to use old one
gem 'protected_attributes'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
