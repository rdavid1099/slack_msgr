# frozen_string_literal: true

module SlackMsgr
  # Handles all requests with Slack API
  class Fetcher
    class << self
      private

      def conn
        oauth_access_token = SlackMsgr.configuration.oauth_access_token
        ErrorHandling.raise(:configuration_error) unless oauth_access_token

        faraday = Faraday.new(url: SLACK_URL) do |config|
          config.request  :url_encoded             # form-encode POST params
          config.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        faraday.authorization :Bearer, oauth_access_token
        faraday
      end
    end
  end
end
