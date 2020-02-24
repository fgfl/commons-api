# frozen_string_literal: true

Twilio.configure do |config|
  config.account_sid = Rails.application.secrets.ACCOUNT_SID
  config.auth_token = Rails.application.secrets.AUTH_TOKEN
end
