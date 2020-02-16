# frozen_string_literal: true

module FormatBillHelper
  # this helper removes the redundant timestamp from the date as it is always the same
  def format_date(items)
    items.each do |item|
      item['pubDate'].slice! ' 00:00:00 EST'
    end
    items
  end

  # this helper moves the bill code to its own hash key
  def format_code(items)
    items.each do |item|
      bill_code = item['title'].split(', ').first
      item['title'].sub! /\A.+?(?=, )/mi, ''
      item['description'].sub! /\A.+?(?=, )/mi, ''
      item['title'].slice!(0, 2)
      item['description'].slice!(0, 2)
      item['code'] = bill_code
    end
    items
  end

  # this helper renames event title and bill titles
  def rename_titles(items)
    items.each do |item|
      item['bill_title'] = item.delete 'description'
      item['event_title'] = item.delete 'title'
    end
    items
  end
end
