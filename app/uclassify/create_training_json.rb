require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper

# set up bills in rb file for saving which needs to be sent to uclassify

file_data = File.read(__dir__ + "/training_data/publications_with_category.xml")

items = JSON.parse(xml_to_json(file_data))["rss"]["channel"]["item"]
bill_items = items.select do |item|
  # item["title"].include? "Legislative Summary"
  !item["title"].include? "Legislative Summary"
end

File.write(__dir__ + "/training_data/research_publications.json", bill_items.to_json)
