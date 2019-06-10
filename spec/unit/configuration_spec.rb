RSpec.describe SlackMsgr::Configuration do
  describe '#initialize' do
    it 'can be initialized without parameters' do
      config = SlackMsgr::Configuration.new

      expect(config.verification_token).to eq(nil)
      expect(config.client_secret).to eq(nil)
      expect(config.signing_secret).to eq(nil)
    end

    it 'can be initialized with parameters' do
      config = SlackMsgr::Configuration.new(
        verification_token: 'foo',
        client_secret:      'bar',
        signing_secret:     'baz'
      )

      expect(config.verification_token).to eq('foo')
      expect(config.client_secret).to eq('bar')
      expect(config.signing_secret).to eq('baz')
    end
  end
end
