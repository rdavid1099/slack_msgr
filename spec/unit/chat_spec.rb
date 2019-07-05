include SlackMsgrHelpers

RSpec.describe SlackMsgr::Chat do
  let(:chat) { SlackMsgr::Chat }

  describe '#call' do
    before(:each) do
      mock_faraday_connection
    end

    it 'creates a new instance of chat with passed method and opts' do
      mock_config_oauth_access_token

      method = :post_message
      opts = {channel: 'announcements', text: 'Hello world'}

      expect(chat).to receive(:new).with(method, opts)
        .and_return(SlackMsgr::Chat.new(method, opts))

      resp = chat.call(method, opts)

      expect(resp[:ok]).to eq(true)
    end

    it 'raises error if invalid method is passed' do
      error_msg = "Method not found: invalid_method does not exist\n" \
        "If you would like this method added, please add an issue at https://github.com/rdavid1099/slack-msgr"
      expect{ chat.call(:invalid_method, {}) }.to raise_error(NoMethodError, error_msg)
    end

    it 'raises error if required arguments are not passed' do
      error_msg = "Required arguments missing: Method chat.postMessage requires arguments:\n" \
        "[ channel, text ] Refer to https://api.slack.com/methods/"
      expect{ chat.call(:post_message, {}) }.to raise_error(ArgumentError, error_msg)
    end
  end

  describe '#new' do
    it 'only sanitizes body to only one permitted argument' do
      method = :post_message
      unsanitized_opts = {channel: 'repeat', text: 'Hello world', not_real: 'wrong', channel: 'announcements', as_user: false}
      result = chat.new(method, unsanitized_opts)
      expect(result.body).to eq({channel: 'announcements', text: 'Hello world', as_user: false}.to_json)
    end
  end
end
