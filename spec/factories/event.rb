FactoryBot.define do

  factory :event do
    association :bill
    title { 'C-204, Introduction and First Reading in the House of Commons' }
    publication_date { 'Fri, 07 Feb 2020' }
  end

  factory :random_event, class: Event do
    association :bill
    title { "C #{Faker::Number.number(digits: 2)} #{Faker::Nation.nationality} #{Faker::IndustrySegments.sector}" }
    publication_date { Faker::Date.backward(days: 365) }
  end

end