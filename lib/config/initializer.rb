# frozen_string_literal: true

require_relative './constants'
require_relative './version'

Dir[File.expand_path 'lib/{slack_msgr,utils}/**/*.rb'].each { |f| require f }
