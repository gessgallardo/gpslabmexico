# frozen_string_literal: true

class Client
  include HTTParty

  base_uri 'https://api.sendgrid.com'
  headers 'Content-Type' => 'application/json', authorization: 'Bearer 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'
  maintain_method_across_redirects true
  default_options.update(verify: false)
  logger ::Logger.new(STDOUT), :debug, :curl
  debug_output $stdout
  # debug_output nil
end
