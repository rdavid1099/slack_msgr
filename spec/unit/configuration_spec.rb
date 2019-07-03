RSpec.describe SlackMsgr::Configuration do
  let(:config) do
    SlackMsgr::Configuration.new(
      verification_token: 'foo',
      client_secret:      'bar',
      signing_secret:     'baz',
      access_tokens:        {bot: 'foobot'}
    )
  end

  describe '#initialize' do
    it 'can be initialized without parameters' do
      blank_config = SlackMsgr::Configuration.new

      expect(blank_config.verification_token).to eq(nil)
      expect(blank_config.client_secret).to eq(nil)
      expect(blank_config.signing_secret).to eq(nil)
      expect(blank_config.access_tokens).to eq({})
    end

    it 'can be initialized with parameters' do
      expect(config.verification_token).to eq('foo')
      expect(config.client_secret).to eq('bar')
      expect(config.signing_secret).to eq('baz')
      expect(config.access_tokens).to eq({bot: 'foobot'})
    end
  end

  describe '#clear!' do
    it 'permanently clears all configuration variables' do
      config.clear!

      expect(config.verification_token).to eq(nil)
      expect(config.client_secret).to eq(nil)
      expect(config.signing_secret).to eq(nil)
    end
  end

  describe '#default_token' do
    it 'returns a single token if there is only one token configured' do
      expect(config.default_token).to eq('foobot')
    end

    it 'returns the first of multiple tokens if no default is configured' do
      configuration = SlackMsgr::Configuration.new(access_tokens: {
        me: 'my-token',
        bot: 'bot-token'
      })

      expect(configuration.default_token).to eq('my-token')
    end

    it 'returns the specified default access token if configured' do
      configuration = SlackMsgr::Configuration.new(
        access_tokens: {
          me: 'my-token',
          bot: 'bot-token',
          friend: 'friend-token'
        },
        set_default_token: :friend
      )

      expect(configuration.default_token).to eq('friend-token')
    end
  end
end
