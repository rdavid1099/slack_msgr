include SlackMsgrHelpers

RSpec.describe 'SlackMsgr#chat :post_message' do
  let(:slack_msgr) { SlackMsgr }

  before(:each) do
    mock_faraday_connection
  end

  it 'sends a token, text and channel to https://slack.com/api/chat.postMessage' do
    configure_slack_msgr(slack_msgr)

    expect_any_instance_of(Faraday::Connection).to receive(:post)

    slack_msgr.chat(:post_message, channel: 'announcements', text: 'Hello world')
  end

  it 'throws error if oauth_access_token is not configured' do
    slack_msgr.configuration.clear!

    error_msg = "Error with configruation: oauth_access_token not found\n" \
      "Be sure to configure all tokens and secrets"

    expect do
      slack_msgr.chat(:post_message, channel: 'announcements', text: 'Hello world')
    end.to raise_error(ConfigurationError, error_msg)
  end
end
