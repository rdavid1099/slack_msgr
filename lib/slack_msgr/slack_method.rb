# frozen_string_literal: true

module SlackMsgr
  # Handles all requests with Slack API
  class SlackMethod
    class << self
      private

      def conn
        @conn ||= Faraday.new(url: SLACK_URL) do |config|
          config.request  :url_encoded             # form-encode POST params
          config.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def conceal(token)
        token.split('Bearer ').last[0..-6].gsub(/[a-zA-Z0-9]/, 'X') + token[-5..-1]
      end

      def add_metadata_to_response(response)
        JSON.parse(response.body, symbolize_names: true)
            .merge!(auth_token: conceal(conn.headers['Authorization']))
      end

      def send_post_request_to_slack(obj)
        conn.authorization :Bearer, SlackMsgr.configuration.oauth_access_token(obj.opts[:use_token])
        response = conn.post do |req|
          req.url "/api/#{obj.method}"
          req.headers['Content-Type'] = 'application/json; charset=utf-8'
          req.body = obj.body
        end
        add_metadata_to_response(response)
      end

      def send_legacy_request_to_slack(obj)
        conn.authorization :Bearer, SlackMsgr.configuration.legacy_token
        response = conn.post do |req|
          req.url "/api/#{obj.method}"
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.body = URI.encode_www_form(obj.body)
        end
        JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
