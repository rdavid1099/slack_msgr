require_relative './version'
Dir[File.join(__dir__, 'slack_msgr', '*.rb')].each { |f| require f }
