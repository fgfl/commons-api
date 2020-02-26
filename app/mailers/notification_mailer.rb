# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'no-reply@commonsapp.ca'

  def send_signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for signing up to Commons.')
  end

  def send_notification_email(user)
    @user = user
    mail(to: @user.email, subject: 'Commons: You have new notifications for bills.')
  end
end
