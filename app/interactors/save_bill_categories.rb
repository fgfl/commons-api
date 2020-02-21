class SaveBillCategories
  include Interactor

  def call
    bill = Bill.find_by(code: "C-212")
    user_categories = context.categories
    user_categories.each do |category|
      category = Category.find_by(uclassify_class: category)
      bill.bill_categories.create(bill_id: bill.id, category_id: category.id)
    end
  end
end
