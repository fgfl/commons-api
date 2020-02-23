require "faraday"
require "faraday_middleware"
require "uri"
require "nokogiri"

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
  def self.get_bill_text(bill)
    faraday = Faraday.new(url: bill["description"]) do |f|
      f.use FaradayMiddleware::FollowRedirects
      f.adapter :net_http
    end
    res = faraday.get
    doc = Nokogiri::HTML(res.body)

    begin
      legisInfo_link = doc.at_css("a:contains('Status of the bill')")["href"]
    rescue NoMethodError => exception
      puts exception.full_message()
      puts "Failed on page #{bill["description"]}"
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
      publication_link = doc.at_css("a:contains('Latest Publication')")["href"]
    rescue NoMethodError => exception
      puts exception.full_message()
      puts "Failed on page #{legisInfo_link}"
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
      bill_xml_link = doc.at_css("a.btn-export-xml:contains('XML')")["href"]
    rescue NoMethodError => exception
      puts exception.full_message()
      puts "Failed on page #{absolute_publication_link}"
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

    all_text = doc.search("//text()").map(&:text)
    [all_text.join(" ")]
    # File.write(__dir__ + "/bill_xml_parsed.txt", all_text.join("\n"))

  end

  # Gets the text on the research publication page given the bill object parsed from the RSS feed
  # {{}}: bill hash
  # Example:
  # {
  #   "xml:base": "https://hillnotes.ca/2020/02/13/5g-technology-opportunities-challenges-and-risks/",
  #   "author": { "name": "Sarah Lemelin-Bellerose" },
  #   "category": ["Information and communications", "Science and technology"],
  #   "title": "5G Technology: Opportunities, Challenges and Risks",
  #   "description": "https://hillnotes.ca/2020/02/13/5g-technology-opportunities-challenges-and-risks/",
  #   "pubDate": "Thu, 13 Feb 2020 00:00:00 -0500"
  # },
  def self.get_publication_text(bill)
    begin
      next_url = URI(bill["description"])

      faraday = Faraday.new(url: next_url.to_s) do |f|
        f.use FaradayMiddleware::FollowRedirects
        f.adapter :net_http
      end
      res = faraday.get

      if next_url.host.include? ("hillnotes.ca")
        parse_hill_notes_site(res.body)
      elsif next_url.host.include? ("lop.parl.ca")
        parse_lop_parl_site(res.body)
      else
        raise StandardError "Not configured to parse url: #{next_url.to_s}"
      end
    rescue Net::ReadTimeout, Faraday::TimeoutError => exception
      puts "error: #{exception.full_message()}"
      puts "response = #{res}"
      return []
    rescue StandardError => exception
      puts "error: #{exception.full_message()}"
      return []
    end
  end

  private

  def self.parse_hill_notes_site(html_string)
    doc = Nokogiri::HTML(html_string)
    begin
      article_elm = doc.at_css("#content.site-content > article")
    rescue NoMethodError => exception
      puts exception.full_message()
      return []
    else
      text = article_elm
        .search(".//text()")
        .map(&:text)
        .join()
        .split(" ")
        .join(" ")

      [text]
    end
  end

  def self.parse_lop_parl_site(html_string)
    doc = Nokogiri::HTML(html_string)
    begin
      text = doc.search("//text()")
        .select { |t| !t.cdata? }
        .map(&:text)
        .join()
        .split(" ")
        .join(" ")

      [text]
    rescue NoMethodError => exception
      puts exception.full_message()
      return []
    end
  end
end
