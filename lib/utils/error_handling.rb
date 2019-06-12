# frozen_string_literal: true

module SlackMsgr
  # Handles all chat functionality and methods corresponding with Slack API
  module ErrorHandling
    class << self
      def raise(error_type, opts)
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
    end
  end
end
