# frozen_string_literal: true
class GetSubscribersFromEvents
  include Interactor

  def call
    events = context.events

    subscribers = {}

    events.each do |event|
      subscribers_for_bill = Bill.find_by(id: event.bill_id).users.where('sms_notification = ? OR email_notification = ?', true, true).as_json
      subscribers_for_bill.each do |subscriber|
        if subscribers[(subscriber[:id])].nil?
          subscribers[(subscriber[:id]).to_s] = {
            name: subscriber["name"],
            phone_number: subscriber["phone_number"],
            sms_notification: subscriber["sms_notification"],
            email: subscriber["email"],
            email_notification: subscriber["email_notification"],
            events: [event]
          }
        else
          subscribers[(subscriber[:id]).to_s][:events].push(event)
        end
      end
    end

    context.subscribers = subscribers
  end
end
