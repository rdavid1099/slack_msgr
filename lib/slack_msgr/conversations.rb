# frozen_string_literal: true

module SlackMsgr
  # Handles all conversations functionality and methods corresponding with Slack API
  class Conversations < SlackMethod
    CONVERSATIONS_METHODS = { open: 'open' }.freeze

    REQUIRED_ARGUMENTS = %i[token users].freeze

    PERMITTED_ARGUMENTS = %i[token channel return_im users].freeze

    class << self
      def call(method, opts = {})
        chat = new(method, opts)
        send_post_request_to_slack(chat)
      end
    end

    attr_reader :method,
                :opts,
                :body

    def initialize(method, opts)
      conversations_method = CONVERSATIONS_METHODS[method]
      ErrorHandling.raise(:unknown_method, method: method) unless conversations_method

      @method = "conversations.#{conversations_method}"
      @opts   = opts
      @body   = sanitize_body
    end

    private

    def sanitize_body
      ErrorHandling.raise(:req_args_missing, req_args: REQUIRED_ARGUMENTS, method: method) if req_args_missing?

      opts.keys.each_with_object({}) do |key, body|
        body[key] ||= opts[key] if PERMITTED_ARGUMENTS.include?(key)
        body
      end.to_json
    end

    def req_args_missing?
      !(REQUIRED_ARGUMENTS - opts.keys).empty?
    end
  end
end
