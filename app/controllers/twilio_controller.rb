class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def sms
    body = helpers.parse_sms(params)
    response = Twilio::TwiML::MessagingResponse.new do |r|
      r.message body: body
    end
    render xml: response.to_s
  end
end
