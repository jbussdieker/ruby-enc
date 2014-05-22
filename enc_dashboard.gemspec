# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'enc_dashboard/version'

Gem::Specification.new do |gem|
  gem.name          = "enc_dashboard"
  gem.version       = EncDashboard::VERSION
  gem.authors       = ["Joshua B. Bussdieker"]
  gem.email         = ["josh.bussdieker@moovweb.com"]
  gem.description   = %q{Puppet dashboard replacement}
  gem.summary       = %q{Puppet dashboard replacement}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.files        << Dir[".bundle/**/*"]
  gem.files        << Dir["vendor/**/*"]
  gem.files        << Dir["public/**/*"]
  gem.files        << "JENKINS"
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
