# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    sequence(:id) { |number| number }
    number { 23 }
    start_date { Faker::Date.in_date_period(year: 2019, month: 12) }
    end_date { Faker::Date.forward(days: 365) }
  end

  factory :random_session, class: Session do
    sequence(:id) { |number| number }
    number { Faker::Number.between(from: 30, to: 43) }
    start_date { Faker::Date.in_date_period(year: 2019, month: 12) }
    end_date { Faker::Date.forward(days: 365) }
  end
end
