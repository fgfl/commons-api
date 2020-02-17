require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper
require_relative "./uclassify"
# include Uclassify

require "pry"
require "faraday"
require "faraday_middleware"
require "uri"
require "nokogiri"

#=========

# res = Uclassify::train(["this is a dog.", "somewhere a cat goes meow", "nowhere does it say a moon can't moo!"], "json-api-test", "test_class2")
# res = Uclassify::train(["this is a dog"], "json-api-test", "test_class2")

# binding.pry

# raise  # just to stop execution

file_data = File.read(__dir__ + "/training_data/publications_with_category.xml")

# File.write(__dir__ + "/test.json", (xml_to_json(file_data)))
items = JSON.parse(xml_to_json(file_data))["rss"]["channel"]["item"]
bill_items = items.select do |item|
  item["title"].include? "Legislative Summary"
end

# pp bill_items[0..4]

# bill_items.each do |bill|
#   puts bill["title"]
#   puts "======"

#   if bill["category"].kind_of?(Array)
#     bill["category"].each do |cat|
#       puts cat
#     end
#   elsif bill["category"].kind_of?(String)
#     puts bill["category"]
#   end

#   puts ""
# end

# Get status of bill page from the Research Publications page
res = Faraday.get(bill_items.first["description"])
File.write(__dir__ + "/lop_site.html", res.body)
doc = Nokogiri::HTML(res.body)
legisInfo_link = doc.at_css("a:contains('Status of the bill')")["href"]

# get the Latest publication from the LegisInfo page
res = Faraday.get(legisInfo_link)
File.write(__dir__ + "/legisInfo.html", res.body)
doc = Nokogiri::HTML(res.body)
publication_link = doc.at_css("a:contains('Latest Publication')")["href"]

# need this to join the future links. The next links are relative links so we use this to get the base url
url = URI(legisInfo_link)

# Get the XML document from the bill page
absolute_publication_link = URI.join(url, publication_link).to_s
faraday = Faraday.new(url: absolute_publication_link) do |f|
  f.use FaradayMiddleware::FollowRedirects
  f.adapter :net_http
end
res = faraday.get
File.write(__dir__ + "/bill_publication.html", res.body)
doc = Nokogiri::HTML(res.body)
bill_xml_link = doc.at_css("a.btn-export-xml:contains('XML')")["href"]

# need to join the page URL to get the base url
absolute_bill_xml_link = URI.join(url, bill_xml_link).to_s
res = Faraday.get(absolute_bill_xml_link)
File.write(__dir__ + "/bill_publication.xml", res.body)
doc = Nokogiri::XML(res.body)
# doc = File.open(__dir__ + "/bill_publication.xml") { |f| Nokogiri::XML(f) }

# binding.pry

all_text = doc.search("//text()").map(&:text)
puts all_text.join("\n")
File.write(__dir__ + "/bill_xml_parsed.txt", all_text.join("\n"))
# pp res.body.scan(/href.*Status of the bill/)
pp Uclassify::classify([all_text.join("\n")], "Frederick", "LHL_midterm_classifier")
