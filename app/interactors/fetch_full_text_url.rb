class FetchFullTextUrl
  include Interactor

  def call
    bills = context.bills
    bills.each do |bill|
      begin
        page_url = bill["page_url"]
        page = Nokogiri::HTML(URI.open(page_url))
        div = page.at_css("div#ctl00_PageContentArea")
        bill_link_div = div.at_css("div.BillPublicationMenu")
        full_text_url_a = bill_link_div.css("a[href]")
        full_text_url = full_text_url_a.first["href"]
      rescue NoMethodError => e
        puts "Rescued: #{e.inspect} on page: #{page_url} running method #{__method__}"
      else
        full_text_url = "https:" + full_text_url
      end
      bill["full_text_url"] = full_text_url
    end
    context.bills = bills
  end
end
