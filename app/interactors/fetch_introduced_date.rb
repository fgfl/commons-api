class FetchIntroducedDate
  include Interactor
  # Called by insert_columns organizer
  # This interactor fetches the date of the Introduction and First Reading of a given bill
  # This field will (rarely) be unavailable, in which case this value is nil

  def call
    bills = context.bills
    bills.each do |bill|
      begin
        page_url = bill["page_url"]
        page = Nokogiri::HTML(URI.open(page_url))
        date = page.text_equals("Introduction and First Reading").first.parent.parent.find("span").child.text
      rescue NoMethodError => e
        puts "Rescued: #{e.inspect} on page: #{page_url} running method #{__method__}"
      else
        introduced_date = Date.parse(date).to_s
      end
      bill["introduced_date"] = introduced_date
    end
    context.bills = bills
  end
end
