class SaveUserCategories
  include Interactor

  def call
    user = context.user
    user_categories = context.categories
    user_categories.each do |category|
      insert_category = Category.find_by(uclassify_class: category)
      UserCategories.create category: insert_category, user: user
    end
  end
end
