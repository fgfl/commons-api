# frozen_string_literal: true

class ReturnBillsWithCategories
  include Interactor

  def call
    bills = Bill.all.includes(:categories)
    categories = Category.all
    bills_with_categories = []
    bills.each do |bill|
      category_ids = bill.categories.pluck(:id)
      bill_copy = bill.clone.attributes
      bill_copy['categories'] = category_ids
      bills_with_categories.push(bill_copy)
    end
    context.bills = bills_with_categories
    context.categories = categories
  end
end
