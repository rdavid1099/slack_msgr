# frozen_string_literal: true

module SlackMsgr
  # Handles all requests with Slack API
  class Fetcher
    class << self
      private

      def conn
        @conn ||= initialize_connection
      end

      def initialize_connection
        conn = Faraday.new(url: SLACK_URL) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        conn.authorization :Bearer, SlackMsgr.configuration.oauth_access_token
        conn
      end
    end
  end
end
