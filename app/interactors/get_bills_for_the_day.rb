class GetBillsForTheDay
  include Interactor
  # Called as part of the SaveCategoriesFromUclassify organizer chain
  # Fetches all bills that were added to the database today

  def call
    bills_for_day = Bill.all.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    full_text_urls = []
    bills_for_day.each do |bill|
      full_text_urls.push(bill.full_text_url)
    end

    context.full_text_urls = full_text_urls
  end
end
