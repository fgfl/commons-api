# frozen_string_literal: true

require 'date'

# this method simply removes the time string from the pubDate field as it is redundant ('00:00:00 EST' for every item)

# I was having issues storing the date as a date object, so I feel it's better to store as a string
# then convert the date to an actual Date object upon saving to the database using the following lines:
# date_parsed = Date.parse(item['pubDate'])
# item['pubDate'] = date_parsed

module FormatDateHelper
  def format_date(items)
    items.each do |item|
      item['pubDate'].slice! ' 00:00:00 EST'
    end
    items
  end
end
