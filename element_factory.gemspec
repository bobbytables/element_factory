# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'element_factory/version'

Gem::Specification.new do |gem|
  gem.name          = "element_factory"
  gem.version       = ElementFactory::VERSION
  gem.authors       = ["Robert Ross"]
  gem.email         = ["robert@creativequeries.com"]
  gem.description   = %q{Element Factory is a more object oriented approach to generating markup.}
  gem.summary       = %q{Element Factory isn't a fancy DSL, it's Ruby, it's friendly, it's neat.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('rspec', '~> 2.11')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('awesome_print')
  gem.add_development_dependency('nokogiri')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rb-fsevent', '~> 0.9.1')

  gem.add_dependency('activesupport', '~> 3.2.11')
end
