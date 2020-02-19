class SaveBills
  include Interactor

  def call
    bills = context.bills
    session = Session.find_by_id (Session.maximum(:id))
    bills.each do |bill|
      puts "Writing Bill #{bill["code"]} to database ..."
      Bill.create(
        session: session,
        code: bill["code"],
        title: bill["title"],
        page_url: bill["page_url"],
        full_text_url: bill["full_text_url"],
        introduced_date: Date.parse(bill["introduced_date"]),
        description: bill["description"],
      )
    end
    puts "Finished writing #{bills.length} bills to the database!"
  end
end
