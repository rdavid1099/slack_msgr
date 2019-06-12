# frozen_string_literal: true

require 'json'
require 'faraday'
require_relative './constants'

Dir[File.expand_path 'lib/{slack_msgr,utils}/**/*.rb'].each { |f| require f }
