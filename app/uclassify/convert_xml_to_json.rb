require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper

# Sends read call to uClassify
# inputs: text {string} - text to classify
#         read_action {string} - one of the three actions "classify", "keywords", "getInformation"
def uclassify_read(text, read_action)
  base_url = "https://api.uclassify.com/v1/"
  username = "Frederick"
  classifierName = "LHL_midterm_classifier"

  options = {
    method: "POST",
    uri: "#{base_url}#{username}/#{classifierName}/classify",
    headers: {
      "Content-Type" => "application/json",
      Authorization: "Token #{Rails.application.secrets[:uclassify][:api_read_key]}",
    },
    body: {
      texts: [text],
    },
    json: true,
  }
end

file_data = File.read(__dir__ + "/training_data/publications_with_category.xml")

# File.write(__dir__ + "/test.json", (xml_to_json(file_data)))
items = JSON.parse(xml_to_json(file_data))["rss"]["channel"]["item"]
bill_items = items.select do |item|
  item["title"].include? "Legislative Summary"
end

# pp bill_items[0..4]

bill_items.each do |bill|
  puts bill["title"]
  puts "======"

  if bill["category"].kind_of?(Array)
    bill["category"].each do |cat|
      puts cat
    end
  elsif bill["category"].kind_of?(String)
    puts bill["category"]
  end

  puts ""
end
