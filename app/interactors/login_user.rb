# frozen_string_literal: true

class LoginUser
  include Interactor::Organizer
  # Authenticates user and returns their associated bills and categories

  organize AuthenticateUser, ReturnUserWithBills
end
