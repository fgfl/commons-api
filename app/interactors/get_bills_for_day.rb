# frozen_string_literal: true

class GetBillsForDay
  include Interactor
  # Called as part of the SaveCategoriesFromUclassify organizer chain
  # Fetches all bills that were added to the database today

  def call
    bills_for_day = Bill.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    context.bills = bills_for_day
  end
end
