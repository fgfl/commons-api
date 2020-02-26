# frozen_string_literal: true

class UpdateUserCategories
  include Interactor

  def call
    user = context.user
    categories = context.categories
    CategoryUser.where(user_id: user.id).destroy_all
    categories.each do |category|
      user.category_users.create(user_id: user.id, category_id: category)
    end
    user_copy = user.clone.attributes
    user_copy['user_categories'] = categories
    context.user = user_copy
  end
end
