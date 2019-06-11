# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  class Chat
    class << self
      def call(method, opts)
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
