# frozen_string_literal: true

class UpdateUser
  include Interactor

  def call
    user = User.find_by_id(context.id)

    user.update(
      name: context.name,
      username: context.username,
      email: context.email,
      password: context.password,
      password_confirmation: context.password_confirmation,
      sms_notification: context.sms_notification,
      email_notification: context.email_notification,
      phone_number: context.phone_number
    )
    context.user = user
  end
end
