include SlackMsgrHelpers

RSpec.describe 'SlackMsgr#chat :post_message' do
  let(:slack_msgr) { SlackMsgr }

  before(:each) do
    configure_slack_msgr(slack_msgr)
  end

  it 'sends a token, text and channel to https://slack.com/api/chat.postMessage' do
    slack_msgr.chat(:post_message, {channel: 'announcements', text: 'Hello world'})
  end
end
