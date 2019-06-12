RSpec.describe SlackMsgr::Chat do
  let(:chat) { SlackMsgr::Chat }
  describe '#call' do
    it 'creates a new instance of chat with passed method and opts' do
      method = :post_message
      opts = {channel: 'announcements', text: 'Hello world'}
      expect(chat).to receive(:new).with(method, opts)

      chat.call(method, opts)
    end

    it 'raises error if invalid method is passed' do
      error_msg = "Method not found: invalid_method does not exist\n" \
        "If you would like this method added, please add an issue at https://github.com/rdavid1099/slack-msgr"
      expect{ chat.call(:invalid_method, {}) }.to raise_error(NoMethodError, )
    end
  end
end