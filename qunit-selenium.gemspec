libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'qunit/selenium/version'

Gem::Specification.new do |gem|
  gem.name          = 'qunit-selenium'
  gem.version       = QUnit::Selenium::VERSION
  gem.summary       = 'Run QUnit tests through Selenium WebDriver'
  gem.description   = 'Run QUnit tests through Selenium WebDriver'
  
  gem.authors       = ['Silvio Montanari']
  gem.homepage      = 'https://github.com/smontanari/qunit-selenium'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_runtime_dependency 'selenium-webdriver'
  gem.add_runtime_dependency "thor"
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
end
