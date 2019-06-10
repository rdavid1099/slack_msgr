# frozen_string_literal: true

module SlackMsgr
  # Configuration class handling config variables set on launch
  class Configuration
    attr_reader :verification_token,
                :client_secret,
                :signing_secret

    def initialize(verification_token: nil, client_secret: nil, signing_secret: nil)
      @verification_token = verification_token
      @client_secret      = client_secret
      @signing_secret     = signing_secret
    end
  end
end
