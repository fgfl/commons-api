class FetchDescription
  include Interactor

  def call
    bills = context.bills
    bills.each do |bill|
      full_text_url = bill["full_text_url"]
      if full_text_url
        begin
          full_text = Nokogiri::HTML(URI.open(full_text_url))
          summary_div = full_text.find(:xpath, ".//*[contains(text(), 'This enactment')]")
        rescue NoMethodError => e
          puts "Rescued: #{e.inspect} on page: #{full_text_url} running method #{__method__}"
        else
          description = summary_div.text.squish!
        end
      end
      bill["description"] = description
    end
    context.bills = bills
  end
end
