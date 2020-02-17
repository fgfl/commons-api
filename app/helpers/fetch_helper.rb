# frozen_string_literal: true

require "rubygems"
require "nokogiri"
require "open-uri"

module FetchHelper
  # this helper fetches the url for the full text of a given bill based on the page_url
  def get_full_text_url(bill)
    page_url = bill["page_url"]
    page = Nokogiri::HTML(URI.open(page_url))
    full_text_url = page.at_css("a:contains('Latest Publication')")["href"]
    full_text_url = "https:" + full_text_url
    full_text_url
  end

  # this helper fetches the date that the bill was introduced at first reading from the bill summary page
  def get_introduced_date(page_url)
    page = Nokogiri::HTML(URI.open(page_url))
    date = page.text_equals("Introduction and First Reading").first.parent.parent.find("span").child.text
    introduced_date = Date.parse(date)
    introduced_date
  end

  # this helper fetches the summary of the bill from the full text of the bill
  def get_description(full_text_url)
    full_text = Nokogiri::HTML(URI.open(full_text_url))
    summary_div = full_text.find(:xpath, ".//*[contains(text(), 'This enactment')]").text
    summary_div
  end
end
