# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

version_prefix = "#{ENV['MAJOR_VERSION']}.#{ENV['MINOR_VERSION']}."

Gem::Specification.new do |gem|
  gem.name          = "enc_dashboard"
  gem.version       = if !ENV['CIRCLE_BUILD_NUM'].nil? && (ENV['CIRCLE_BUILD_NUM'] != '')
                        if ENV["CIRCLE_BRANCH"] != "master"
                          version_prefix + ENV["CIRCLE_BUILD_NUM"] + ".pre"
                        else
                          version_prefix + ENV["CIRCLE_BUILD_NUM"]
                        end
                      else
                        version_prefix + ENV.fetch("BUILD_NUMBER", "dev")
                      end
  gem.authors       = ["Joshua B. Bussdieker"]
  gem.email         = ["josh.bussdieker@moovweb.com"]
  gem.description   = %q{Puppet dashboard replacement}
  gem.summary       = %q{Puppet dashboard replacement}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.files        << Dir[".bundle/**/*"]
  gem.files        << Dir["vendor/**/*"]
  gem.files        << Dir["public/**/*"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
