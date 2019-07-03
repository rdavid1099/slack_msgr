include SlackMsgrHelpers

RSpec.describe 'SlackMsgr#chat :post_message' do
  let(:slack_msgr) { SlackMsgr }

  before(:each) do
    mock_faraday_connection
  end

  it 'sends a default token, text and channel to https://slack.com/api/chat.postMessage' do
    configure_slack_msgr(slack_msgr, token: {bot: 'bot-token-beep-boop'})

    expect_any_instance_of(Faraday::Connection).to receive(:post)

    slack_msgr.chat(:post_message, channel: 'announcements', text: 'Hello world')
  end

  it 'throws error if oauth_access_token is not configured' do
    slack_msgr.configuration.clear!

    error_msg = "Error with configruation: access_tokens not found\n" \
      "At least one oauth token must be configured using access_tokens"

    expect do
      slack_msgr.chat(:post_message, channel: 'announcements', text: 'Hello world')
    end.to raise_error(ConfigurationError, error_msg)
  end
end
