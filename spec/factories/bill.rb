FactoryBot.define do

  factory :bill do
    association :session
    code { "C-204" }
    title { "Canadian Bum Toucher Act" }
    description { "An Act to touch bums."}
    tabled_date { Faker::Date.backward(days: 365) }
    page_url { "https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760" }
    full_text_url { "https://parl.ca/DocumentViewer/en/10633126" }
  end

  factory :random_bill, class: Bill do
    association :session
    code { "C-#{Faker::Number.number(digits: 2)}" }
    title { "#{Faker::Games::ElderScrolls.region} #{Faker::Relationship.parent} #{Faker::Verb.base} #{Faker::Games::Witcher.quote} Act" }
    description { Faker::Quotes::Shakespeare.king_richard_iii_quote}
    tabled_date { Faker::Date.backward(days: 365) }
    page_url { "https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760" }
    full_text_url { "https://parl.ca/DocumentViewer/en/10633126" }
  end
  
end