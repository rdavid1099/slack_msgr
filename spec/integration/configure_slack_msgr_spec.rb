RSpec.describe 'configure SlackMsgr with tokens and secrets' do
  it 'using SlackMsgr#configure' do
    SlackMsgr.configure do |config|
      config.verification_token = 'foo'
      config.client_secret      = 'bar'
      config.signing_secret     = 'baz'
      config.access_tokens      = {
        bot: 'xoxb-1234567',
        me: 'xoxp-1234567'
      }
    end

    expect(SlackMsgr.configuration.verification_token).to eq('foo')
    expect(SlackMsgr.configuration.client_secret).to eq('bar')
    expect(SlackMsgr.configuration.signing_secret).to eq('baz')
    expect(SlackMsgr.configuration.signing_secret).to eq('baz')
    expect(SlackMsgr.configuration.access_tokens[:bot]).to eq('xoxb-1234567')
    expect(SlackMsgr.configuration.access_tokens[:me]).to eq('xoxp-1234567')
  end
end
