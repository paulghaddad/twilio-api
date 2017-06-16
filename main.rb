require "./sms_sending_service"
require 'pry'

# Add Messaging Service
client = TwilioServiceWrapper.new
# new_service = client.create_message_service("Paul's Messaging Service")

# puts new_service.sid

# List all Message Services
services = client.list_message_services
services.each do |service|
  puts "Service: #{service.sid} #{service.friendly_name}"
end

# List a single Messaging Service
single_service_sid = client.list_message_services.sample.sid
service = client.view_service(single_service_sid)
puts "Single Service: #{service.sid} #{service.friendly_name}"

# Delete a Message Service
service_to_delete_sid = client.create_message_service("Service to Delete").sid
puts "Service Deleted: #{client.delete_service(service_to_delete_sid)}"
# client.delete_service("MGec91ba3417034fcaa949535c2d0d6121")

# Update a Message Service
# service_to_update = client.list_message_services.sample
# updated_service = client.update_service(service_to_update.sid, friendly_name: "#{service_to_update.friendly_name} Updated!")
# puts "Service Updated: #{updated_service.friendly_name}"

# List numbers by friendly name
number = client.list_numbers_by_friendly_name("Paul's Test Number 1").first
puts "Name: #{number.friendly_name} Number: #{number.phone_number}"

# List all numbers
# numbers = client.list_all_numbers
# numbers.each do |number|
#   puts "Number: #{number.phone_number} Friendly Name: #{number.friendly_name}"
# end

# Add number to messaging service
service = client.view_service("MG9edb0847b6258296a9023225ac64f667")
number = client.list_numbers_by_friendly_name("Paul's Test Number 4").first
# client.add_long_phone_number(service: service, number: number)

# Send a message with Copilot
# ["12487946052", "12313608781", "19084000171", "19282746271", "13106343242"].each do |send_number|
#   client.send_message(message_service: service, to_number: send_number)
# end

# Test campaigns with Copilot
["13106343242"].each do |send_number|
  client.send_message(message_service: service, to_number: send_number)
end
