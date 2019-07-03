# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  module ErrorHandling
    class << self
      def raise(error_type, opts = {})
        err = send(error_type, opts)

        Kernel.raise err[:exception], err[:message]
      end

      def unknown_method(opts)
        {
          exception: NoMethodError,
          message: "Method not found: #{opts[:method] || 'unknown_method'} does not exist\n" \
            "If you would like this method added, please add an issue at #{GITHUB_REPO}"
        }
      end

      def configuration_error(_opts)
        {
          exception: ConfigurationError,
          message: "Error with configruation: access_tokens not found\n" \
            'At least one oauth token must be configured using access_tokens'
        }
      end

      def req_args_missing(opts)
        {
          exception: ArgumentError,
          message: "Required arguments missing: Method #{opts[:method]} requires arguments:\n" \
            "[ #{opts[:req_args].join(', ')} ] Refer to https://api.slack.com/methods/"
        }
      end
    end
  end
end

# Define custom error class for more descriptive exceptions
class ConfigurationError < StandardError
end
