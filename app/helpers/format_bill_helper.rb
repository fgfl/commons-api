# frozen_string_literal: true

module FormatBillHelper
  # this helper removes the redundant timestamp from the date as it is always the same
  # def format_date(items)
  #   items.each do |item|
  #     item["pubDate"].slice! " 00:00:00 EST"
  #   end
  #   items
  # end

  # this helper moves the bill code to its own hash key and removes it from the title fields
  # NOTE: 'title' refers to title of bill event, 'description' becomes the title of the bill itself
  # def format_bill_code(items)
  #   items.each do |item|
  #     bill_code = item["title"].split(", ").first
  #     item["title"].sub! /\A.+?(?=, )/mi, ""
  #     item["description"].sub! /\A.+?(?=, )/mi, ""
  #     item["title"].slice!(0, 2)
  #     item["description"].slice!(0, 2)
  #     item["code"] = bill_code
  #     item["bill_code"] = bill_code
  #   end
  #   items
  # end

  # this helper renames the event
  def rename_event_titles(events)
    events.each do |event|
      event["code"] = event.delete "bill_code"
      event["publication_date"] = event.delete "pubDate"
    end
    events
  end

  # this helper renames the bill title and link fields
  def rename_bill_titles(bills)
    bills.each do |bill|
      bill["title"] = bill.delete "description"
      bill["page_url"] = bill.delete "link"
    end
    bills
  end
end
