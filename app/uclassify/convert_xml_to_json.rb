require_relative "../helpers/xml_to_json_helper"
include XmlToJsonHelper

require "dotenv"
Dotenv.load
require "pry"
require "faraday"
require "faraday_middleware"
require "uri"
require "ruby-cheerio"
require "nokogiri"

# Sends read call to uClassify
# inputs: text {string} - text to classify
#         read_action {string} - one of the three actions "classify", "keywords", "getInformation"
def uclassify_read(text, read_action)
  base_url = "https://api.uclassify.com/v1/"
  username = "Frederick"
  classifierName = "LHL_midterm_classifier"

  uri = "#{base_url}#{username}/#{classifierName}/#{read_action}"

  faraday = Faraday.new(url: uri) do |conn|
    # conn.token_auth("#{ENV["UCLASSIFY_API_READ_KEY"]}") # this doesn't work???? must put in header.
    # conn.request :json, :content_type => /\bjson$/
    conn.response :json, :content_type => /\bjson$/
    conn.adapter :net_http
  end

  body = {
    texts: [text],
  }

  pp "body"
  pp body

  pp "body.to_json"
  pp "#{body.to_json}"

  res = faraday.post do |req|
    req.headers["Content-Type"] = "application/json"
    req.headers["Authorization"] = "Token #{ENV["UCLASSIFY_API_READ_KEY"]}"
    req.body = body.to_json
    # req.body = "{\"texts\": [\"hello\"]}"
  end
end

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

res = Faraday.get(bill_items.first["description"])
File.write(__dir__ + "/lop_site.html", res.body)
jQuery = RubyCheerio.new(res.body)
legisInfo_link = jQuery.find("a:contains('Status of the bill')")[0].prop("a", "href")

res = Faraday.get(legisInfo_link)
File.write(__dir__ + "/legisInfo.html", res.body)
jQuery = RubyCheerio.new(res.body)
publication_link = jQuery.find("a:contains('Latest Publication')")[0].prop("a", "href")
# pp publication_link

faraday = Faraday.new(url: "http:#{publication_link}") do |f|
  f.use FaradayMiddleware::FollowRedirects
  f.adapter :net_http
end
res = faraday.get
File.write(__dir__ + "/bill_publication.html", res.body)
jQuery = RubyCheerio.new(res.body)
bill_xml_link = jQuery.find("a.btn-export-xml:contains('XML')")[0].prop("a", "href")

# pp bill_xml_link

# need to join the page URL to get the base url
res = Faraday.get(URI.join("https://www.parl.ca/DocumentViewer/en/42-1/bill/C-101/royal-assent", bill_xml_link).to_s)
File.write(__dir__ + "/bill_publication.xml", res.body)
doc = Nokogiri::XML(res.body)
# doc = File.open(__dir__ + "/bill_publication.xml") { |f| Nokogiri::XML(f) }

# binding.pry

all_text = doc.search("//text()").map(&:text)
puts all_text.join("\n")
File.write(__dir__ + "/bill_xml_parsed.txt", all_text.join("\n"))
# pp res.body.scan(/href.*Status of the bill/)
pp uclassify_read(all_text.join("\n"), "classify")
