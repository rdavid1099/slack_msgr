RSpec.describe 'configure SlackMsgr with tokens and secrets' do
  it 'using SlackMsgr#configure' do
    SlackMsgr.configure do |config|
      config.verification_token = 'foo'
      config.client_secret      = 'bar'
      config.signing_secret     = 'baz'
    end

    expect(SlackMsgr.configuration.verification_token).to eq('foo')
    expect(SlackMsgr.configuration.client_secret).to eq('bar')
    expect(SlackMsgr.configuration.signing_secret).to eq('baz')
  end
end
