# frozen_string_literal: true

namespace :notify do
  desc 'Sends out notifications for users daily'
  task send_notifications: :environment do
    puts "Sending out notifications"
    OrganizeSendNotifications.call
    puts "Finished sending out notifications"
  end

  desc 'Test email sender.'
  task send_test: :environment do
    puts 'Sending out test notifications'
    NotificationMailer.send_test_email('pascalvanleeuwen604@gmail.com').deliver_now
    SendSmsNotifications.call(phone_number: 7789600255, body: 'Testing testing testing.')
    puts 'Finished sending out test notifications'
  end

  desc 'Test email sender.'
  task send_test_heroku: :environment do
    puts 'SENDING OUT HEROKU NOTIFICATION TEST'
    TestSendNotifications.call
    puts 'FINISHED SENDING OUT HEROKU NOTIFICATION TEST'
  end

end
