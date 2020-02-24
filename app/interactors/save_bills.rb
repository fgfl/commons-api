# frozen_string_literal: true

class SaveBills
  include Interactor
  # Called by write_to_db organizer
  # This interactor saves the Bills to the database
  # Bills are associated to the current (most recent) Session of Parliament

  def call
    bills = context.bills

    session = Session.find_by_id Session.maximum(:id)
    bills.each do |bill|
      p "Writing Bill #{bill['code']} to database ... "
      date = Date.parse(bill['introduced_date']) if bill['introduced_date']
      Bill.find_or_create_by(
        session: session,
        code: bill['code'],
        title: bill['title'],
        page_url: bill['page_url'],
        full_text_url: bill['full_text_url'],
        introduced_date: date,
        description: bill['description']
      )
    end
    p "Finished writing #{bills.length} bills to the database!"
  end
end
