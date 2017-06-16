require 'twilio-ruby'

class TwilioServiceWrapper
  attr_reader :client

  def initialize
    account_sid = "AC3de8746d146e0409a44ebfe5ba5f89be"
    auth_token = "daec00e9ac47aa464b09f171a7fc5396"
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  def create_message_service(name)
    client.messaging.v1
      .services
      .create(
        friendly_name: name,
        status_callback: "http://requestb.in/1234abcd")
  end

  def list_message_services
    client.messaging.v1.services.list
  end

  def view_service(sid)
    client.messaging.v1
      .services(sid)
      .fetch
  end

  def update_service(sid, update_params)
    client.messaging.v1
      .services(sid)
      .update(update_params)
  end

  def delete_service(sid)
    client.messaging.v1
      .services(sid)
      .delete
  end

  def list_numbers_by_friendly_name(name)
    client.incoming_phone_numbers.list({
      friendly_name: name
    })
  end

  def list_all_numbers
    client.incoming_phone_numbers.list.each do |number|
      puts "Number: #{number.phone_number} Friendly Name: #{number.friendly_name}"
    end
  end

  def add_long_phone_number(service:, number:)
    client.messaging.v1
      .services(service.sid)
      .phone_numbers
      .create(phone_number_sid: number.sid)
  end

  def send_message(message_service:, to_number:)
    client.messages.create(
      messaging_service_sid: message_service.sid,
      to: to_number,
      body: 'Campaign Test'
  )
  end
end
