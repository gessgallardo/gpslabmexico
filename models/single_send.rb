# frozen_string_literal: true

# SingleSend creator
class SingleSend < Client
  attr_accessor :name, :categories, :sender_id, :status, :custom_unsubscribe_url
  attr_accessor :id, :suppression_group_id, :filter, :send_at, :template_id
  attr_accessor :updated_at, :created_at, :ip_pool

  def initialize(subject: 'La revolución de los sueros antiaging', name:)
    @name = name
    @subject = subject
  end

  def mailer
    @mailer ||= Mailer.new(name: name)
  end

  def payload # rubocop:disable Metrics/MethodLength
    {
      "title": 'News: Segle Clinical',
      "subject": subject,
      "sender_id": 686_567,
      "segment_ids": ['f5d2edfe-b2b5-4fde-8376-243fc17334b2'],
      "categories": ['mailing'],
      "suppression_group_id": 9892,
      "ip_pool": 'marketing',
      "html_content": mailer.html_content,
      "plain_content": 'Tu navegador no soporta contenido dinamico'
    }
  end

  def create
    Campaing.post('/v3/marketing/singlesends', payload)
  end

  def self.all(limit: 1000, offset: 0)
    get('/v3/marketing/singlesends')
  end
end
