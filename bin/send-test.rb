require 'sendgrid-ruby'

include SendGrid

mail = Mail.new
mail.from = Email.new(email: 'test@example.com')
personalization = Personalization.new
personalization.add_to(Email.new(email: 'hola@gessgallardo.com'))
mail.add_personalization(personalization)
mail.template_id = 'd-2c214ac919e84170b21855cc129b4a5f'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

begin
    response = sg.client.mail._("send").post(request_body: mail.to_json)
rescue Exception => e
    puts e.message
end

puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers
