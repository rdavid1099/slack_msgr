RSpec.describe SlackMsgr::Authenticate do
  # Stub signature data taken from Slack's docs on verifying signatures
  # https://api.slack.com/authentication/verifying-requests-from-slack
  let(:signing_secret) { "8f742231b10e8888abcd99yyyzzz85a5" }
  let(:request) {
    OpenStruct.new(
      headers: {
        "X-Slack-Signature" => "v0=a2114d57b48eac39b9ad189dd8316235a7b4a8d21a10bd27519666489c69b503",
        "X-Slack-Request-Timestamp" => "1531420618"
      },
      body: StringIO.new("token=xyzz0WbapA4vBCDEFasx0q6G&team_id=T1DC2JH3J&team_domain=testteamnow&channel_id=G8PSS9T3V&channel_name=foobar&user_id=U2CERLKJA&user_name=roadrunner&command=%2Fwebhook-collect&text=&response_url=https%3A%2F%2Fhooks.slack.com%2Fcommands%2FT1DC2JH3J%2F397700885554%2F96rGlfmibIGlgcZRskXaIFfN&trigger_id=398738663015.47445629121.803a0bc887a14d10d2c447fce8b6703c")
    )
  }



  describe "#verification_token?" do
    before(:each) do
      SlackMsgr.configure { |config| config.verification_token = "xyzz" }
    end

    it "returns true if token matches configured verification_token" do
      expect(SlackMsgr::Authenticate.verification_token?("xyzz")).to eq(true)
    end

    it "returns false if token does not match configured verification_token" do
      expect(SlackMsgr::Authenticate.verification_token?("wrong")).to eq(false)
    end
  end

  describe "#signing_secret?" do
    before(:each) do
      allow(SlackMsgr::Authenticate).to receive(:timestamp_over_five_minutes_old?).and_return(false)
    end

    it "returns true if slack signature is verified" do
      SlackMsgr.configure { |config| config.signing_secret = signing_secret }

      expect(SlackMsgr::Authenticate.signing_secret?(request)).to eq(true)
    end

    it "returns false if slack signature is not verified" do
      SlackMsgr.configure { |config| config.signing_secret = "wrong" }

      expect(SlackMsgr::Authenticate.signing_secret?(request)).to eq(false)
    end
  end
end
