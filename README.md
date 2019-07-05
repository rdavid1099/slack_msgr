# SlackMsgr

[![Build Status](https://semaphoreci.com/api/v1/rworkman1099/slack-msgr/branches/master/badge.svg)](https://semaphoreci.com/rworkman1099/slack-msgr)
[![Maintainability](https://api.codeclimate.com/v1/badges/b0b292347eea43d4c414/maintainability)](https://codeclimate.com/github/rdavid1099/slack-msgr/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b0b292347eea43d4c414/test_coverage)](https://codeclimate.com/github/rdavid1099/slack-msgr/test_coverage)

Under construction 🚧 Release is still in very early development. Limited, basic functionality is available.

## Requirements
* Ruby >= 2.3

SlackMsgr depends on these other gems for usage at runtime:
* [Faraday](https://github.com/lostisland/faraday) handles requests to and from [SlackAPI](https://api.slack.com/)

## Installation
Add the following line to a Gemfile:

    gem 'slack_msgr'

and run `bundle install` from your shell.

If you use Rubygems, run this command manually from your shell to install the latest poke-api-v2 version:

    gem install slack_msgr

## Configuration
This gem must be configured with credentials provided by Slack. _NOTE: These tokens are secret and given uniquely to you to access your workspace. It is strongly advised to store these in an environment variable and not directly in your configuration file._

### Using Rails
If you are using this gem with a Rails project, create an initializer file.

```ruby
# ./config/initializers/slack_msgr.rb

SlackMsgr.configure do |config|
  config.verification_token = '1a2b3c4d5e'
  config.client_secret      = 'a1b2c3d4e5'
  config.signing_secret     = 'aa11bb22cc3'
  config.access_tokens      = {
    bot: 'xoxp-1234567-xxxxxxxxx',
    me: 'xoxb-1234567-xxxxxxxxx'
  }
end
```

_NOTE_: All access tokens are configured as a hash. The name of the keys are arbitrary, and there is no limit to keys that can be configured.

Multiple oauth tokens can be used during a single session. Oauth tokens are declared in the method execution. For example, considering the configuration above, to use the token attached to the key `:me` simply pass the parameter `use_token: :me`.

```ruby
SlackMsgr.chat(:post_message,
  use_token: :me,
  channel: 'announcements',
  text: 'Hello world'
)
```

SlackMsgr will try to use a default token if a method is called without declaring `use_token:`. SlackMsgr takes the first token in the `access_tokens` hash as a default.

If you are using this gem outside of a Rails project, follow the configuration pattern above, but be sure to run this code before using any functionality of the gem.

## Usage
_SlackMsgr is still in the early stages of development and has limited functionality. Please refer to the [issues](https://github.com/rdavid1099/slack-msgr/issues) for future development and if you would like to help out._

SlackMsgr follows SlackAPI's patterns for methods and functionality. Posting a message in Slack using its API, for example, requires making a `POST` request to `https://slack.com/api/chat.postMessage`. You can execute this identical functionality in SlackMsgr by calling `SlackMsgr.chat(:post_message)`. A `POST` request to `https://slack.com/api/channels.info` would simply be `SlackMsgr.channels(:info)`. Please refer to the list of available functions below for a complete summary of what is built out in this early stage of development.

### SlackMsgr#chat
All options passed to a chat function follow the patterns and arguments described by the [SlackAPI Documentation](https://api.slack.com/methods). SlackMsgr uses the `bot_user_oauth_access_token` passed in the configuration to send out the messages. At this moment, only one `bot_user_oauth_access_token` can be configured at a time and there is no way to send a message as one user and then send a consecutive message as a different user. This functionality will be built out in the future.

Available functions:
- `:post_message`: [chat.postMessage SlackAPI Docs](https://api.slack.com/methods/chat.postMessage)

```ruby
SlackMsgr.chat(:post_message, channel: 'announcements', text: 'Hello world')
# Sends the text 'Hello world' to the announcements channel

SlackMsgr.chat(:post_message, {
  use_token: :bot,
  channel: "C1H9RESGL",
  text: "Here's a message for you",
  as_user: false,
  username: "testing",
  attachments: [{
    text: "This is an attachment",
    id: 1,
    fallback: "This is an attachment's fallback"
  }]
})
# Sends a message with an attachment using the oauth token configured for :bot as a user with the username 'testing'
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
