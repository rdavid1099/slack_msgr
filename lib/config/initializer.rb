# frozen_string_literal: true

require_relative './version'

Dir[File.expand_path "lib/slack_msgr/**/*.rb"].each { |f| require f }
