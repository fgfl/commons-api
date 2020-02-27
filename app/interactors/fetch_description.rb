# frozen_string_literal: true

class FetchDescription
  include Interactor
  # Called by insert_columns organizer
  # This interactor fetches the description from the Summary field of the a bill publication
  # If the bill has no text available it will not run and 'description' will be nil

  def call
    bills = context.bills
    bills.each do |bill|
      full_text_url = bill['full_text_url']
      if full_text_url
        begin
          full_text = Nokogiri::HTML(URI.open(full_text_url))
          summary_div = full_text.find(:xpath, ".//*[contains(text(), 'This enactment')]")
        rescue NoMethodError => e
          puts "No description available for Bill #{bill['code']}. Skipping ..."
        else
          description = summary_div.text.squish!
        end
      end
      bill['description'] = description
    end
    context.bills = bills
  end
end
