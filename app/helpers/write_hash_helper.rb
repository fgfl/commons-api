# frozen_string_literal: true

require 'json'
require 'active_support/all'
# require 'rubygems'
# require 'nikkou'
# require 'open-uri'

# bring in the format_bill_helper
require_relative './format_bill_helper'
include FormatBillHelper

# bring in the fetch helpers and insert_columns_into_bills method
require_relative './fetch_helper'
include FetchHelper

module WriteHashHelper
  # this helper splits the hash file into two separate arrays, one for events and one for bills
  # it also ensures that there are no duplicate instances of bills
  def split_hash(items)
    split_hash = [[], []]
    hash_keys = %w[bill_code title pubDate]
    items.each do |event|
      event, bill = event.partition { |k, _v| hash_keys.include? k }.map(&:to_h)
      split_hash[0].push(event)
      split_hash[1].push(bill)
    end
    split_hash[1] = split_hash[1].uniq
    split_hash
  end

  # this helper reads the xml file from the legisINFO RSS feed, formats the data and writes to .rb hash files
  # the folder path for the files to written to can be passed to the function as parameters wherever it is called as a relative path
  def write_hash(read_path, write_path)
    file_data = File.read(__dir__ + read_path)
    hash = JSON.parse(Hash.from_xml(file_data).to_json)
    items = hash['rss']['channel']['item']
    format_date(items)
    format_bill_code(items)
    split_hash = split_hash(items)
    events = split_hash[0]
    bills = split_hash[1]
    rename_event_titles(events)
    rename_bill_titles(bills)
    insert_columns_into_bills(bills)
    File.write(__dir__ + write_path + '/events_hash.rb', events)
    File.write(__dir__ + write_path + '/bills_hash.rb', bills)
  end
end
