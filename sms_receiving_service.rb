require 'sinatra'
require "./sms_sending_service"

get '/' do
    'Twilio'
end

post '/' do
  from_number = params[:From]
  body = params[:Body].downcase
  client = TwilioServiceWrapper.new
  service = client.view_service("MG9edb0847b6258296a9023225ac64f667")
  "You sent me a text from #{from_number} with #{body}"
  if body.match(/hello/)
    client.send_message(message_service: service, to_number: from_number, body: "You said hello!")
  elsif body.match(/good/)
    client.send_message(message_service: service, to_number: from_number, body: "You said goodbye!")
  else
    client.send_message(message_service: service, to_number: from_number, body: "You didn't say anything!")
  end
end
