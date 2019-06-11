# Collection of helper methods for specs
module SlackMsgrHelpers
  module_function

  def configure_slack_msgr(msgr, opts = {})
    msgr.configure do |config|
      config.verification_token = opts[:verification_token] || 'foo'
      config.client_secret      = opts[:client_secret] || 'bar'
      config.signing_secret     = opts[:signing_secret] || 'baz'
    end
  end
end
