# frozen_string_literal: true

class SendNotifications
  include Interactor

  # example subscriber hash
  #   {"1"=>
  #   {:name=>"ffff",
  #    :phone_number=>"1234567890",
  #    :sms_notification=>true,
  #    :email=>"ff@ff.com",
  #    :email_notification=>true,
  #    :events=>
  #     [#<Event:0x00007f6ed811f2f8
  #       id: 1,
  #       bill_id: 1,
  #       code: "C-224",
  #       title: "Introduction and First Reading in the House of Commons",
  #       publication_date: Tue, 25 Feb 2020,
  #       created_at: Tue, 25 Feb 2020 19:19:28 EST -05:00,
  #       updated_at: Tue, 25 Feb 2020 19:19:28 EST -05:00>,
  #      #<Event:0x00007f6ed811dfc0
  #       id: 3,
  #       bill_id: 3,
  #       code: "C-219",
  #       title: "Introduction and First Reading in the House of Commons",
  #       publication_date: Tue, 25 Feb 2020,
  #       created_at: Tue, 25 Feb 2020 19:19:28 EST -05:00,
  #       updated_at: Tue, 25 Feb 2020 19:19:28 EST -05:00>,
  #      #<Event:0x00007f6ed811d868
  #       id: 4,
  #       bill_id: 4,
  #       code: "C-220",
  #       title: "Introduction and First Reading in the House of Commons",
  #       publication_date: Tue, 25 Feb 2020,
  #       created_at: Tue, 25 Feb 2020 19:19:28 EST -05:00,
  #       updated_at: Tue, 25 Feb 2020 19:19:28 EST -05:00>]},
  #       ...
  #   }

  def call
    subscribers = context.subscribers

    subscribers.each do |_subscriber_id, subscriber|
      if subscriber[:sms_notification] && !subscriber[:phone_number].nil? && !subscriber[:phone_number].empty?
        puts "Sending SMS notifications to #{subscriber[:name]} at #{DateTime.now} ..."        
        SendSmsNotifications.call(subscriber: subscriber)
      end

      if subscriber[:email] && !subscriber[:email].nil? && !subscriber[:email].empty?
        puts "Sending email notifications to #{subscriber[:name]} at #{DateTime.now} ..."
        NotificationMailer.send_notification_email(subscriber).deliver_now
      end
    end
  end
end
