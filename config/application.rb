# frozen_string_literal: true

require 'bundler'
require 'dotenv'

AUTOLOAD_DIRS = %w[
  config
  models
].freeze
SEGLE_ENV = ENV.fetch('RACK_ENV', 'development').freeze

Bundler.require(:default, SEGLE_ENV.to_sym)
Dotenv.load(
  '.env',
  '.env.local'
)

AUTOLOAD_DIRS.each do |dir|
  require_all dir
end
