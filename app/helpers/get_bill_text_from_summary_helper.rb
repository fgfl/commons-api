# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'uri'
require 'nokogiri'

module GetBillTextFromSummaryHelper
  # Gets the text of a bill given the bill object parsed from the RSS feed
  # {{}}: bill hash
  # Example:
  # {
  #   "xml:base": "https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/LegislativeSummaries/421C101E",
  #   "author": [{ "name": "Bashar Abu Taleb" }, { "name": "Offah Obale" }],
  #   "category": [
  #     "Law, justice and rights",
  #     "Business, industry and trade",
  #     "Economics and finance",
  #     "Government, Parliament and politics"
  #   ],
  #   "title": "Legislative Summary of Bill C-101: An Act to amend the Customs Tariff and the Canadian International Trade Tribunal Act",
  #   "description": "https://lop.parl.ca/sites/PublicWebsite/default/en_CA/ResearchPublications/LegislativeSummaries/421C101E",
  #   "pubDate": "Wed, 10 Jul 2019 00:00:00 -0400"
  # },
  def self.get_text(bill)
    faraday = Faraday.new(url: bill['description']) do |f|
      f.use FaradayMiddleware::FollowRedirects
      f.adapter :net_http
    end
    res = faraday.get
    doc = Nokogiri::HTML(res.body)

    begin
      legisInfo_link = doc.at_css("a:contains('Status of the bill')")['href']
    rescue NoMethodError => e
      puts e.full_message
      puts "No full text available for bill: #{bill['description']}"
      return []
    end

    # get the Latest publication from the LegisInfo page
    faraday = Faraday.new(url: legisInfo_link) do |f|
      f.use FaradayMiddleware::FollowRedirects
      f.adapter :net_http
    end
    res = faraday.get
    doc = Nokogiri::HTML(res.body)
    begin
      publication_link = doc.at_css("a:contains('Latest Publication')")['href']
    rescue NoMethodError => e
      puts e.full_message
      puts "No latest publication available from link: #{legisInfo_link}"
      return []
    end

    # need this to join the future links. The next links are relative links so we use this to get the base url
    url = URI(legisInfo_link)

    # Get the XML document from the bill page
    absolute_publication_link = URI.join(url, publication_link).to_s
    faraday = Faraday.new(url: absolute_publication_link) do |f|
      f.use FaradayMiddleware::FollowRedirects
      f.adapter :net_http
    end
    res = faraday.get
    doc = Nokogiri::HTML(res.body)
    begin
      bill_xml_link = doc.at_css("a.btn-export-xml:contains('XML')")['href']
    rescue NoMethodError => e
      puts e.full_message
      puts "No XML document available from page: #{absolute_publication_link}"
      return []
    end

    # need to join the page URL to get the base url
    absolute_bill_xml_link = URI.join(url, bill_xml_link).to_s
    faraday = Faraday.new(url: absolute_bill_xml_link) do |f|
      f.use FaradayMiddleware::FollowRedirects
      f.adapter :net_http
    end
    res = faraday.get
    doc = Nokogiri::XML(res.body)

    all_text = doc.search('//text()').map(&:text)
  end
end
