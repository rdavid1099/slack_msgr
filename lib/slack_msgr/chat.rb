# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  class Chat < SlackMethod
    CHAT_METHODS = { post_message: 'postMessage' }.freeze

    REQUIRED_ARGUMENTS = %i[channel text].freeze

    PERMITTED_ARGUMENTS = %i[
      token
      channel
      text
      as_user
      attachments
      blocks
      icon_emoji
      icon_url
      link_names
      mrkdwn
      parse
      reply_broadcast
      thread_ts
      unfurl_links
      unfurl_media
      username
    ].freeze

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
      chat_method = CHAT_METHODS[method]
      ErrorHandling.raise(:unknown_method, method: method) unless chat_method

      @method = "chat.#{chat_method}"
      @opts   = opts
      @body   = sanitize_body
    end

    private

    def sanitize_body
      ErrorHandling.raise(:req_args_missing, req_args: REQUIRED_ARGUMENTS, method: method) if req_args_missing? # rubocop:disable LineLength
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
