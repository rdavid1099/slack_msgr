include SlackMsgrHelpers

RSpec.describe 'SlackMsgr#chat :post_message' do
  let(:slack_msgr) { SlackMsgr }

  before(:each) do
    mock_faraday_connection
  end

  it 'sends a default token, text and channel to https://slack.com/api/chat.postMessage' do
    configure_slack_msgr(slack_msgr)

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

  it 'sends text to channel with given token to https://slack.com/api/chat.postMessage' do
    given_me_token     = 'xoxp-1234567890-123456789012-abcdefghijklmnopqrstuzwx'
    expected_me_token  = 'XXXX-XXXXXXXXXX-XXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXtuzwx'
    given_bot_token    = 'bot-token-beep-boop'
    expected_bot_token = 'XXX-XXXXX-XXXX-boop'
    configure_slack_msgr(slack_msgr, access_tokens: {
      bot: given_bot_token,
      me: given_me_token
    })

    expect_any_instance_of(Faraday::Connection).to receive(:post)

    response = slack_msgr.chat(:post_message,
      use_token: :me,
      channel: 'announcements',
      text: 'Hello world'
    )

    expect(response.body[:auth_token]).to eq(expected_me_token)

    response = slack_msgr.chat(:post_message,
      use_token: :bot,
      channel: 'announcements',
      text: 'Hello world'
    )

    expect(response.body[:auth_token]).to eq(expected_bot_token)
  end
end
