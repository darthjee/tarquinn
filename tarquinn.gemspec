# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tarquinn/version'

Gem::Specification.new do |gem|
  gem.name          = 'tarquinn'
  gem.version       = Tarquinn::VERSION
  gem.authors       = %w(DarthJee)
  gem.email         = %w(darthjee@gmail.com)
  gem.homepage      = 'https://github.com/darthje/tarquinn'
  gem.description   = 'Gem for easy redirection controll'
  gem.summary       = gem.description

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'bundler',   '~> 1.16.1'
  gem.add_development_dependency 'rake',      '~> 13.0.1'
  gem.add_development_dependency 'rspec',     '~> 3.9.0'
  gem.add_development_dependency 'simplecov', '~> 0.17.1'
  gem.add_development_dependency 'pry',       '~> 0.12.2'
  gem.add_development_dependency 'pry-nav',   '~> 0.3.0'
end
