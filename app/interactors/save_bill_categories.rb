class SaveBillCategories
  include Interactor

  def call
    bill_code = context.bill_code
    bill = Bill.find_by(code: bill_code)
    user_categories = context.categories
    user_categories.each do |category|
      category = Category.find_by(uclassify_class: category)
      bill.bill_categories.create(bill_id: bill.id, category_id: category.id)
      puts "Saved category #{category.name} to Bill #{bill.code}"
    end
  end
end
