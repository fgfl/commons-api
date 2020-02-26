# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'no-reply@commonsapp.ca'

  def send_signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for signing up to Commons.')
  end
end
