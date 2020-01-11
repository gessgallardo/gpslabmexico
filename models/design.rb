# frozen_string_literal: true

# Design creator
class Design < Client
  attributes = %i[
    id name generate_plain_content
    thumbnail_url subject created_at
    pdated_at editor categories
  ]
  attr_accessor(*attributes)

  def initialize(subject: 'La revolución de los sueros antiaging', name:)
    @name = name
    @subject = subject
  end

  def mailer
    @mailer ||= Mailer.new(name: name)
  end

  def payload
    @html_content ||= mailer.html_content
    {
      headers: {"Content-Type" => "application/json"},
      body: {
        title: name,
        subject: subject,
        editor: 'code',
        categories: ['mailing'],
        html_content: @html_content,
        plain_content: 'Tu navegador no soporta contenido dinamico'
      }
    }
  end

  def create
    Design.post('/v3/designs', {a: 1, b: 2})
  end

  def self.all
    get('/v3/designs')
  end
end
