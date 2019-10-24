# frozen_string_literal: true

module SlackMsgr
  # Configuration class handling config variables set on launch
  class Configuration
    attr_accessor :verification_token,
                  :client_secret,
                  :signing_secret,
                  :legacy_token,
                  :access_tokens,
                  :set_default_token

    def initialize(
      verification_token: nil,
      client_secret: nil,
      signing_secret: nil,
      legacy_token: nil,
      access_tokens: {},
      set_default_token: nil
    )
      @verification_token = verification_token
      @client_secret      = client_secret
      @signing_secret     = signing_secret
      @legacy_token       = legacy_token
      @access_tokens      = access_tokens
      @set_default_token  = set_default_token
    end

    def clear!
      @verification_token = nil
      @client_secret      = nil
      @signing_secret     = nil
      @legacy_token       = nil
      @access_tokens      = {}
      @set_default_token  = nil
      @default_token      = nil
    end

    def default_token
      @default_token ||= initialize_default_token
    end

    def initialize_default_token
      return unless access_tokens&.first

      access_tokens[set_default_token] || access_tokens.first[1]
    end

    def oauth_access_token(given_token)
      token = access_tokens[given_token] || default_token
      ErrorHandling.raise(:configuration_error) unless token
      token
    end
  end
end
