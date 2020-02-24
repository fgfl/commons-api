# frozen_string_literal: true

class RemoveDuplicates
  include Interactor
  # Called by write_to_db organizer

  # This interactor renames certain fields, as seen below
  # It also ensures each hash value is unique

  def call
    events = context.events
    events.each do |event|
      event['code'] = event.delete 'bill_code'
      event['publication_date'] = event.delete 'pubDate'
    end
    events = events.uniq

    bills = context.bills
    bills.each do |bill|
      bill['title'] = bill.delete 'description'
      bill['page_url'] = bill.delete 'link'
    end
    bills = bills.uniq

    context.events = events
    context.bills = bills
  end
end
