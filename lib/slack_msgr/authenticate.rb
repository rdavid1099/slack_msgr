# frozen_string_literal: true

module SlackMsgr
  # Handles various authentication patterns offered by Slack
  class Authenticate
    class << self
      def verification_token?(token)
        token == SlackMsgr.configuration.verification_token
      end

      def signing_secret?(request)
        signature = request.headers['X-Slack-Signature']
        timestamp = request.headers['X-Slack-Request-Timestamp']
        version   = signature.split('=').first
        body      = request.body.read

        # The request timestamp is more than five minutes from local time.
        # It could be a replay attack, so let's ignore it.
        return false if timestamp_over_five_minutes_old?(timestamp)

        signature == "#{version}=#{compute_hash_sha256(version, timestamp, body)}"
      end

      private

      def compute_hash_sha256(version, timestamp, body)
        digest = OpenSSL::Digest::SHA256.new
        OpenSSL::HMAC.hexdigest(digest, SlackMsgr.configuration.signing_secret, "#{version}:#{timestamp}:#{body}")
      end

      def timestamp_over_five_minutes_old?(timestamp)
        (Time.now - Time.at(timestamp.to_i)) > (60 * 5)
      end
    end
  end
end
