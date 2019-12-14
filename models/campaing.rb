# frozen_string_literal: true

# Campaing creator
class Campaing
  include HTTParty
  attr_accessor :name, :subject

  base_uri 'https://api.sendgrid.com'
  headers authorization: 'Bearer tWZAvVRmSf2y_mwzMFh67A'
  maintain_method_across_redirects true
  logger ::Logger.new('http_logger'), :debug
  debug_output $stdout

  def initalize(subject: 'La revolución de los sueros antiaging', name:)
    @name = name
    @subject = subject
  end

  def payload # rubocop:disable Metrics/MethodLength
    {
      "title": 'News: Segle Clinical',
      "subject": subject,
      "sender_id": 535_919,
      "segment_ids": ['f5d2edfe-b2b5-4fde-8376-243fc17334b2'],
      "categories": ['mailing'],
      "suppression_group_id": 9892,
      "ip_pool": 'marketing',
      "html_content": GenerateMailer.new(name: name),
      "plain_content": 'Tu navegador no soporta contenido dinamico'
    }
  end

  def self.create
    post('/v3/campaigns', payload)
  end

  def self.all(limit: 1000, offset: 0)
    get("/v3/campaigns")
  end
end
