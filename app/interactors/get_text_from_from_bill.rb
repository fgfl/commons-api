# frozen_string_literal: true

class GetTextFromFromBill
  include Interactor
  # Called as part of the SaveCategoriesFromUclassify organizer chain
  # Gets text from each bill and passes down teh bill code for each bill

  def call
    # Need this to join the future links. The next links are relative links so we use this to get the base url
    bills = context.bills

    # Get the XML document from the bill page
    bills.each do |bill|
      begin
        if bill.full_text_url.nil?
          raise StandardError.new "No url Found for bill: #{bill}"
        end

        # Creates Faraday connection to bill
        faraday = Faraday.new(url: bill.full_text_url) do |f|
          f.use FaradayMiddleware::FollowRedirects
          f.adapter :net_http
        end
        res = faraday.get
        doc = Nokogiri::HTML(res.body)
        bill_xml_link = doc.at_css("a.btn-export-xml:contains('XML')")['href']

        # Need to join the page URL to get the base url
        absolute_bill_xml_link = URI.join(bill.full_text_url, bill_xml_link).to_s
        faraday = Faraday.new(url: absolute_bill_xml_link) do |f|
          f.use FaradayMiddleware::FollowRedirects
          f.adapter :net_http
        end

        res = faraday.get
        doc = Nokogiri::XML(res.body)

        # Assigns full_text and bill_code to be passed to ClassifyAndSaveCategories organizer chain.
        full_text = doc.search('//text()').map(&:text)
        if full_text.empty?
          raise StandardError, "No text Found for page: #{full_text_url}"
        end

        bill_code = bill.code
      rescue NoMethodError => e
        puts e.full_message
        puts "Failed on page: #{full_text_url}"
        next
      rescue StandardError => e
        puts e.full_message
        next
      else
        # Calls ClassifyAndSaveCategories organizer chain on the text from each bill
        ClassifyAndSaveCategories.call(full_text: full_text, bill_code: bill_code)
      end
    end
  end
end
