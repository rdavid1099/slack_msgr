RSpec.describe SlackMsgr::Configuration do
  let(:config) do
    SlackMsgr::Configuration.new(
      verification_token: 'foo',
      client_secret:      'bar',
      signing_secret:     'baz'
    )
  end

  describe '#initialize' do
    it 'can be initialized without parameters' do
      blank_config = SlackMsgr::Configuration.new

      expect(blank_config.verification_token).to eq(nil)
      expect(blank_config.client_secret).to eq(nil)
      expect(blank_config.signing_secret).to eq(nil)
    end

    it 'can be initialized with parameters' do
      expect(config.verification_token).to eq('foo')
      expect(config.client_secret).to eq('bar')
      expect(config.signing_secret).to eq('baz')
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
end
