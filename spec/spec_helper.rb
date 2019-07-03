require 'bundler/setup'
require 'pry'
require 'simplecov'
Dir[File.expand_path 'spec/helpers/**/*.rb'].each { |f| require f }

SimpleCov.start

require './lib/slack_msgr'

RSpec.configure do |config|
  config.before(:each) do
    SlackMsgr.configuration.clear!
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
