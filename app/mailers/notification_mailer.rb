# frozen_string_literal: true

class NotificationMailer < ActionMailer::Base
  default from: 'no-reply@commonsapp.ca'

  def send_signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for signing up to Commons.')
  end

  def send_notification_email(subscriber)
    @subscriber = subscriber
    mail(to: @subscriber[:email], subject: 'Commons App: You have new notifications for your watched bills.')
  end

  def send_test_email(user)
    @user = user
    mail(to: @user, subject: 'TESTTESTTESTYPOO')
  end
end
