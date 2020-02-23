# frozen_string_literal: true

class SaveUserCategories
  include Interactor
  # Saves user categories to the database, associated through the category_users model

  def call
    user = context.user
    user_categories = context.categories
    user_categories.each do |category|
      category = Category.find_by(id: category)
      user.category_users.create(user_id: user.id, category_id: category.id)
    end
  end
end
