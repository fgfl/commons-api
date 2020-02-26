# frozen_string_literal: true

class UpdateUserAndCategories
  include Interactor::Organizer

  organize UpdateUser, UpdateUserCategories
end
