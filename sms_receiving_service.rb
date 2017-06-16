require 'sinatra'
require "./sms_sending_service"

get '/' do
    'Twilio'
end

post '/' do
  from_number = params[:From]
  body = params[:Body]
  client = TwilioServiceWrapper.new
  service = client.view_service("MG9edb0847b6258296a9023225ac64f667")
  client.send_message(message_service: service, to_number: from_number, body: "Here you go!")
  "Received a text from #{from_number} with #{body}"
end
