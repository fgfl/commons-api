# frozen_string_literal: true

# this helper reads the xml file from the legisINFO RSS feed, formats the data and writes to .rb hash files
# the folder path for the files to written to can be passed to the function as parameters wherever it is called as a relative path
# def write_hashes_array(read_path, write_path)
#   file_data = File.read(__dir__ + read_path)
#   hash = JSON.parse(Hash.from_xml(file_data).to_json)
#   items = hash['rss']['channel']['item']
#   format_date(items)
#   format_bill_code(items)
#   split_arrays = split_arrays(items)
#   events = split_arrays[0]
#   bills = split_arrays[1]
#   rename_event_titles(events)
#   rename_bill_titles(bills)
#   insert_columns_into_bills(bills)
#   File.write(__dir__ + write_path + '/event_hashes_array.rb', events)
#   File.write(__dir__ + write_path + '/bills_hashes_array.rb', bills)
# end

# for now method reads from file. need to replace with results of api call
# def read_file
#   file_data = File.read(__dir__ + "/../../spec/support/legisinfo_test_data.xml")
#   hash = JSON.parse(Hash.from_xml(file_data).to_json)
#   items = hash["rss"]["channel"]["item"]
#   format_date(items)
#   format_bill_code(items)
#   items
# end

require "json"
require "active_support/all"

# bring in the format_bill_helper
require_relative "./format_bill_helper"
include FormatBillHelper

# bring in the fetch helpers and insert_columns_into_bills method
require_relative "./fetch_helper"
include FetchHelper

module WriteDatabaseHelper

  #formats XML file data from legisINFO website
  def format_xml_to_hashes_array
    legisinfo_xml_feed = get_legisinfo_xml_feed
    hash = JSON.parse(Hash.from_xml(legisinfo_xml_feed).to_json)
    items = hash["rss"]["channel"]["item"]
    format_date(items)
    format_bill_code(items)
    items
  end

  # this helper splits the hash file into two separate arrays, one for events and one for bills
  # it also ensures that there are no duplicate instances of bills
  def split_arrays
    items = format_xml_to_hashes_array
    split_arrays = [[], []]
    hash_keys = %w[bill_code title pubDate]
    items.each do |event|
      event, bill = event.partition { |k, _v| hash_keys.include? k }.map(&:to_h)
      split_arrays[0].push(event)
      split_arrays[1].push(bill)
    end
    rename_event_titles(split_arrays[0])
    rename_bill_titles(split_arrays[1])
    split_arrays[0] = split_arrays[0].uniq
    split_arrays[1] = split_arrays[1].uniq
    split_arrays
  end

  # this helper writes events to the database
  # each event is associated to a specific bill by the bill code (eg. C-204)
  def write_events
    split_arrays = split_arrays()
    events = split_arrays[0]
    events.each do |event|
      puts event
      puts "Writing Event #{event["code"]} #{event["title"]} to database ..."
      bill = Bill.find_by code: event["code"]
      Event.create(
        bill: bill,
        code: event["code"],
        title: event["title"],
        publication_date: Date.parse(event["publication_date"]),
      )
    end
    puts "Finished writing #{events.length} events to the database!"
  end

  # this helper writes bills to the database
  # each bills is associated to a specific session (currently only one session exists)
  def write_bills
    split_arrays = split_arrays()
    bills = split_arrays[1]
    insert_columns_into_bills(bills)
    session = Session.first
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
