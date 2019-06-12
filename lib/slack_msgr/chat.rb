# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  class Chat < Fetcher
    CHAT_METHODS = {
      post_message: 'postMessage'
    }.freeze

    class << self
      def call(method, opts = {})
        chat = new(method, opts)

        conn.post do |req|
          req.url "/api/#{chat.method}"
          req.headers['Content-type'] = 'application/json'
          req.body = chat.body
        end
      end
    end

    attr_reader :method,
                :opts

    def initialize(method, opts)
      chat_method = CHAT_METHODS[method]
      ErrorHandling.raise(:unknown_method, method: method) unless chat_method

      @method = "chat.#{chat_method}"
      @body   = initialize_body(opts)
    end

    private

    def initialize_body
      opts.to_json
    end
  end
end
