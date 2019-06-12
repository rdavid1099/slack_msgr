# frozen_string_literal: true

module SlackMsgr
  # Configuration class handling config variables set on launch
  class Configuration
    attr_accessor :verification_token,
                  :client_secret,
                  :signing_secret,
                  :oauth_access_token,
                  :bot_user_oauth_access_token

    def initialize(
      verification_token: nil,
      client_secret: nil,
      signing_secret: nil,
      oauth_access_token: nil,
      bot_user_oauth_access_token: nil
    )
      @verification_token          = verification_token
      @client_secret               = client_secret
      @signing_secret              = signing_secret
      @oauth_access_token          = oauth_access_token
      @bot_user_oauth_access_token = bot_user_oauth_access_token
    end

    def clear!
      @verification_token          = nil
      @client_secret               = nil
      @signing_secret              = nil
      @oauth_access_token          = nil
      @bot_user_oauth_access_token = nil
    end
  end
end
