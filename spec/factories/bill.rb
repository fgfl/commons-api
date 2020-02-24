# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    sequence(:id) { |number| number }
    association :parliamentary_session
    code { 'C-204' }
    title { 'Canadian Super Special Political Thingy' }
    description { 'An Act to Do a Thing for Stuff' }
    introduced_date { Faker::Date.backward(days: 365) }
    page_url { 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760' }
    full_text_url { 'https://parl.ca/DocumentViewer/en/10633126' }
  end

  factory :random_bill, class: Bill do
    sequence(:id) { |number| number }
    association :parliamentary_session
    code { "C-#{Faker::Number.number(digits: 2)}" }
    title { "#{Faker::Games::ElderScrolls.region} #{Faker::Relationship.parent} #{Faker::Verb.base} #{Faker::Games::Witcher.quote} Act" }
    description { Faker::Quotes::Shakespeare.king_richard_iii_quote }
    introduced_date { Faker::Date.backward(days: 365) }
    page_url { 'https://www.parl.ca/LegisInfo/BillDetails.aspx?Language=E&billId=10626760' }
    full_text_url { 'https://parl.ca/DocumentViewer/en/10633126' }
  end
end
