class RemoveDuplicates
  include Interactor

  def call
    events = context.events
    events.each do |event|
      event["code"] = event.delete "bill_code"
      event["publication_date"] = event.delete "pubDate"
    end
    events = events.uniq

    bills = context.bills
    bills.each do |bill|
      bill["title"] = bill.delete "description"
      bill["page_url"] = bill.delete "link"
    end
    bills = bills.uniq

    context.events = events
    context.bills = bills
  end
end
