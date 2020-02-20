class SaveUserAndCategories
  include Interactor::Organizer
  # Called by Users controller
  # Takes in a user JSON object with categories from the front end and saves to database.

  organize SaveUser, SaveUserCategories
end
