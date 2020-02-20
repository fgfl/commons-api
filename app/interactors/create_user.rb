class CreateUser
  include Interactor::Organizer
  # Called by Users controller
  # This organizer runs through the process of creating a new user

  organize SaveUserToDatabase
end
