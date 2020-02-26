class GetSubscribersFromEvents
  include Interactor

  def call
    events = context.events

    subscribers = {}

    events.each do |event|
      sms_subscribers = Bill.find_by(id: event.bill_id).users.where("sms_notification = ? OR email_notification = ?", true, true)
      sms_subscribers.each do |s|
        if subscribers["#{s["id"]}"].nil?
          subscribers["#{s["id"]}"] = {
            name: s["name"],
            phone_number: s["phone_number"],
            sms_notification: s["sms_notification"],
            email: s["email"],
            email_notification: s["email_notification"],
            events: [event],
          }
        else
          subscribers["#{s["id"]}"][:events].push(event)
        end
      end
    end

    context.subscribers = subscribers
  end
end
