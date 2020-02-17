# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'

module FetchHelper
  def get_page_urls(array)
    page_urls = []
    array.each do |bill|
      page_urls.push(bill['page_url'])
    end
    page_urls
  end

  def get_full_text_urls(array)
    page_urls = get_page_urls(array)
    full_text_urls = []
    page_urls.each do |page_url|
      page = Nokogiri::HTML(open(page_url))
      div = page.at_css('div#ctl00_PageContentArea')
      bill_link_div = div.at_css('div.BillPublicationMenu')
      full_text_url_a = bill_link_div.css('a[href]')
      full_text_url = full_text_url_a.first['href']
      full_text_url = 'https:' + full_text_url
      full_text_urls.push(full_text_url)
    end
    full_text_urls
  end
end
