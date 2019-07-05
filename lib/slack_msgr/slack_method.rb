# frozen_string_literal: true

module SlackMsgr
  # Handles all requests with Slack API
  class SlackMethod
    class << self
      private

      attr_reader :conn

      def establish_connection(given_token = nil)
        @conn ||= Faraday.new(url: SLACK_URL) do |config|
          config.request  :url_encoded             # form-encode POST params
          config.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        conn.authorization :Bearer, SlackMsgr.configuration.oauth_access_token(given_token)
      end

      def conceal(token)
        token.split('Bearer ').last[0..-6].gsub(/[a-zA-Z0-9]/, 'X') + token[-5..-1]
      end

      def add_metadata_to_response(response)
        JSON.parse(response.body, symbolize_names: true)
          .merge!(auth_token: conceal(conn.headers['Authorization']))
      end

      def send_post_request_to_slack(obj)
        establish_connection(obj.opts[:use_token])
        response = conn.post do |req|
          req.url "/api/#{obj.method}"
          req.headers['Content-Type'] = 'application/json; charset=utf-8'
          req.body = obj.body
        end
        add_metadata_to_response(response)
      end
    end
  end
end
