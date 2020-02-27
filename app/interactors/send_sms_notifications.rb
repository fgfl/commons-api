# frozen_string_literal: true

class SendSmsNotifications
  include Interactor

  def call
    character_limit = 1200

    subscriber = context.subscriber

    body = "Hello #{subscriber[:name]}.\n\nYou are receiving this message because you are subscribed to bill events on the Commons App.\n\nThere are new events for your subscribed bills:\n\n"

    subscriber[:events].each do |e|
      bill = Bill.find_by(id: e[:bill_id])
      body += "Bill #{e.code}: #{e.title}\nPublished: #{e.publication_date}\n#{bill.page_url}\n\n"
      if body.length > character_limit 
        body += "Text limit exceeded.\n\n(Coming soon: See your full watch list at http://commonsapp.ca)\n\n"
        break
      end
    end

    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])

    client.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: "+1#{subscriber[:phone_number]}",
      body: body
    )
    puts "SMS message sent to phone number: #{subscriber[:phone_number]} ..."
  end
end
