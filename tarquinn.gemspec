# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tarquinn/version'

Gem::Specification.new do |gem|
  gem.name          = 'tarquinn'
  gem.version       = Tarquinn::VERSION
  gem.authors       = %w[DarthJee]
  gem.email         = %w[darthjee@gmail.com]
  gem.homepage      = 'https://github.com/darthje/tarquinn'
  gem.description   = 'Gem for easy redirection controll'
  gem.summary       = gem.description

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'bundler',   '~> 2.5.13'
  gem.add_development_dependency 'pry',       '~> 0.14.2'
  gem.add_development_dependency 'pry-nav',   '~> 1.0.0'
  gem.add_development_dependency 'rake',      '~> 13.1.0'
  gem.add_development_dependency 'rspec',     '~> 3.12.0'
  gem.add_development_dependency 'simplecov', '~> 0.22.0'
  gem.metadata['rubygems_mfa_required'] = 'true'
end
