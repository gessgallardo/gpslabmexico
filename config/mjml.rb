# frozen_string_literal: true

# Regular Ruby
MJML.configure do |config|
  #config.bin_path = 'yarn run mjml'
  config.logger = Logger.new(STDOUT)
  config.minify_output = true
  config.validation_level = :soft
end
