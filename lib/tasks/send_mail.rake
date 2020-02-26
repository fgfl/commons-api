# frozen_string_literal: true

namespace :notification do
  desc 'Sends out notifications for users daily'
  task send_email: :environment do
    NotificationMailer
  end

  desc 'TODO'
  task send_test_email: :environment do
    NotificationMailer.send_test_email('pascalvanleeuwen604@gmail.com').deliver
  end
end
