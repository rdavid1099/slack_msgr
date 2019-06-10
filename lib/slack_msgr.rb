# frozen_string_literal: true

require_relative './config/initializer'

# Main module housing all classes, modules and methods for SlackMsgr
module SlackMsgr
  class << self
    def configuration
      @configuration ||= Configuration.new
    end
  end
end
