class SaveUserAndCategories
  include Interactor::Organizer

  organize SaveUser, SaveUserCategories
end
