# frozen_string_literal: true

class SendSmsNotifications
  include Interactor

  def call
    phone_number = context.phone_number
    body = context.body

    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    client.messages.create(
      from: ENV['PHONE_NUMBER'],
      to: "+1#{phone_number}",
      body: body
    )
  end
end
