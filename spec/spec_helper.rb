# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'tarquinn'
require 'pry-nav'

require 'active_record'
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: ':memory:'
)

require File.expand_path('spec/dummy/config/environment')
#require File.expand_path('spec/dummy/db/schema.rb')
require 'rspec/rails'
require 'active_support/railtie'

support_files = File.expand_path('spec/support/**/*.rb')
Dir[support_files].each { |file| require file }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :integration unless ENV['ALL']

  config.order = 'random'

  # config.before do
  # end
end
