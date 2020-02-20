class SaveUserCategories
  include Interactor

  def call
    user = context.user
    user_categories = context.categories
    user_categories.each do |category|
      category = Category.find_by(uclassify_class: category)
      user.category_users.create(user_id: user.id, category_id: category.id)
    end
  end
end
