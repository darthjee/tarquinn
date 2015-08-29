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

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.6"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.14"
  gem.add_development_dependency 'simplecov'
end
