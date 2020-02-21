class GetBillsForTheDay
  include Interactor

  def call
    bills_for_day = Bill.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    context.bills_for_day = bills_for_day
  end
end
