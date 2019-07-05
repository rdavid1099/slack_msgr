# Collection of helper methods for specs
module SlackMsgrHelpers
  module_function

  def configure_slack_msgr(msgr, opts = {})
    msgr.configure do |config|
      config.verification_token = opts[:verification_token] || 'foo'
      config.client_secret      = opts[:client_secret] || 'bar'
      config.signing_secret     = opts[:signing_secret] || 'baz'
      config.access_tokens      = opts[:access_tokens] || {bot: 'xoxb-1234567', me: 'xoxp-1234567'}
    end
  end

  def mock_faraday_connection
    allow_any_instance_of(Faraday::Connection).to receive(:post).and_return(
      double("response", status: 200, body: {"ok" => true}.to_json)
    )
  end

  def mock_config_oauth_access_token
    allow_any_instance_of(SlackMsgr::Configuration).to receive(:default_token)
    .and_return('xoxo-xxxx-xxxxxxxxx-xxxx')
  end
end
