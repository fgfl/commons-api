# frozen_string_literal: true

class AuthenticateUser
  include Interactor

  def call
    user = context.user
    password = context.password
    if user&.authenticate(password)
      context.user = user
    else
      context.fail!(message: 'authenticate_user.failure')
    end
  end
end
