# frozen_string_literal: true

module SlackMsgr
  # Handles all users functionality and methods corresponding with Slack API
  class Users < SlackMethod
    USERS_METHODS = {
      admin: 'admin',
      invite: 'invite'
    }.freeze

    REQUIRED_ARGUMENTS = %i[email].freeze

    PERMITTED_ARGUMENTS = %i[
      token
      email
      channels
      real_name
      resend
      restricted
      ultra_restricted
      expiration_ts
    ].freeze

    class << self
      def call(method, opts = {})
        users = new(method, opts)
        send_legacy_request_to_slack(users)
      end
    end

    attr_reader :method,
                :opts,
                :body

    def initialize(methods, opts)
      users_method = methods.map do |method|
        ErrorHandling.raise(:unknown_method, method: method) unless USERS_METHODS[method]

        USERS_METHODS[method]
      end.join('.')

      @method = "users.#{users_method}"
      @opts   = opts
      @body   = sanitize_body
    end

    private

    def sanitize_body
      ErrorHandling.raise(:req_args_missing, req_args: REQUIRED_ARGUMENTS, method: method) if req_args_missing?

      opts.merge!(token).keys.each_with_object({}) do |key, body|
        body[key] ||= opts[key] if PERMITTED_ARGUMENTS.include?(key)
        body
      end
    end

    def req_args_missing?
      !(REQUIRED_ARGUMENTS - opts.keys).empty?
    end

    def token
      { token: SlackMsgr.configuration.legacy_token }
    end
  end
end
