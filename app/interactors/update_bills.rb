class UpdateBills
  include Interactor

  def call
    bills = context.bills

    Bill.upsert_all(bills, unique_by: [:id, :code])
  end
end