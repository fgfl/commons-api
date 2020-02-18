# frozen_string_literal: true

require 'rubygems'
require 'nikkou'
require 'open-uri'

module FetchHelper
  def get_page_url(bill)
    begin
      page_url = bill['page_url']
    rescue NoMethodError => e
      puts "Rescued: #{e.inspect} on bill: #{bill.code} running method #{__method__}"
    end
    page_url
  end

  # this helper fetches the url for the full text of a given bill based on the page_url
  def get_full_text_url(page_url)
    begin
      page = Nokogiri::HTML(URI.open(page_url))
      div = page.at_css('div#ctl00_PageContentArea')
      bill_link_div = div.at_css('div.BillPublicationMenu')
      full_text_url_a = bill_link_div.css('a[href]')
      full_text_url = full_text_url_a.first['href']
    rescue NoMethodError => e
      puts "Rescued: #{e.inspect} on page: #{page_url} running method #{__method__}"
    else
      full_text_url = 'https:' + full_text_url
    end
    full_text_url
  end

  # this helper fetches the date that the bill was introduced at first reading from the bill summary page
  def get_introduced_date(page_url)
    begin
      page = Nokogiri::HTML(URI.open(page_url))
      date = page.text_equals('Introduction and First Reading').first.parent.parent.find('span').child.text
    rescue NoMethodError => e
      puts "Rescued: #{e.inspect} on page: #{page_url} running method #{__method__}"
    else
      introduced_date = Date.parse(date).to_s
    end
    introduced_date
  end

  # this helper fetches the summary of the bill from the full text of the bill
  def get_description(full_text_url)
    begin
      full_text = Nokogiri::HTML(URI.open(full_text_url))
      summary_div = full_text.find(:xpath, ".//*[contains(text(), 'This enactment')]")
    rescue NoMethodError => e
      puts "Rescued: #{e.inspect} on page: #{full_text_url} running method #{__method__}"
    else
      description = summary_div.text
    end
    description
  end

  # this helper loops through the array of hashes and inserts the above 3 columns with values
  def insert_columns_into_bills(bills)
    bills.each do |bill|
      page_url = get_page_url(bill)
      full_text_url = get_full_text_url(page_url)
      introduced_date = get_introduced_date(page_url)
      description = get_description(full_text_url) if full_text_url
      bill['full_text_url'] = full_text_url
      bill['introduced_date'] = introduced_date
      bill['description'] = description
    end
  end
end
