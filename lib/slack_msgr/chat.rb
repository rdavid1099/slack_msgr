# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  class Chat
    class << self
      def call(method, opts = {})
        ErrorHandling.raise(:unknown_method, method: method) unless CHAT_METHODS.include?(method)

        initialize = new(method, opts)
      end
    end

    attr_reader :method,
                :opts

    def initialize(method, opts)
      @method = method
      @opts   = opts
    end
  end
end
