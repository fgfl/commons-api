# frozen_string_literal: true

class ReturnUserWithBills
  include Interactor

  def call
    user = context.user
    user_copy = user.clone.attributes
    user_copy['user_bills'] = []
    user_copy['user_categories'] = []
    bills = user.bills.all
    categories = user.categories.all
    bills&.each do |bill|
      user_copy['user_bills'].push(bill.id)
    end
    categories&.each do |category|
      user_copy['user_categories'].push(category.id)
    end
    context.user = user_copy
  end
end
