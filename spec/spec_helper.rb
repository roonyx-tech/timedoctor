require 'simplecov'
require 'bundler/setup'
require 'webmock/rspec'
require 'timedoctor'
require_relative 'timedoctor/declarations'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Declarations
end
