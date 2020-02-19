class FetchColumns
  include Interactor

  def call
    bills = context.bills
    bills.each do |bill|
      InsertColumns.call(bill)
    end
  end
end
