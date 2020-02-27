# frozen_string_literal: true
require 'pry'
class GetSubscribersFromEvents
  include Interactor

  def call
    events = context.events

    subscribers = {}

    events.each do |event|
      subscribers = Bill.find_by(id: event.bill_id).users.where('sms_notification = ? OR email_notification = ?', true, true)
      binding.pry
      subscribers.each do |subscriber|
        subscriber.to_h
        if subscribers[(subscriber[:id]).to_s].nil?
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
