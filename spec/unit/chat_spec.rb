RSpec.describe SlackMsgr::Chat do
  let(:chat) { SlackMsgr::Chat }
  describe '#call' do
    it 'creates a new instance of chat with passed method and opts' do
      method = :post_message
      opts = {channel: 'announcements', text: 'Hello world'}
      expect(chat).to receive(:new).with(method, opts)

      chat.call(method, opts)
    end
  end
end
