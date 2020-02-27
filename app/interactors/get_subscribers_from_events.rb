# frozen_string_literal: true

class GetSubscribersFromEvents
  include Interactor

  def call
    events = context.events

    subscribers = {}

    events.each do |event|
      subscribers = Bill.find_by(id: event.bill_id).users.where('sms_notification = ? OR email_notification = ?', true, true)
      subscribers.each do |s|
        if subscribers[(s['id']).to_s].nil?
          subscribers[(s['id']).to_s] = {
            name: s['name'],
            phone_number: s['phone_number'],
            sms_notification: s['sms_notification'],
            email: s['email'],
            email_notification: s['email_notification'],
            events: [event]
          }
        else
          subscribers[(s['id']).to_s][:events].push(event)
        end
      end
    end

    context.subscribers = subscribers
  end
end
