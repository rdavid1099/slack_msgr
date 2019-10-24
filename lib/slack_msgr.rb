# frozen_string_literal: true

require_relative './config/initializer'

# Main module housing all classes, modules and methods for SlackMsgr
module SlackMsgr
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      nil
    end

    def chat(method, opts = {})
      Chat.call(method, opts)
    end

    def users(*methods, **opts)
      Users.call(methods, opts)
    end
  end
end
