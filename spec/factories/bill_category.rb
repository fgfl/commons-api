# frozen_string_literal: true

FactoryBot.define do
  factory :bill_category do
    sequence(:id) { |number| number }
    association :bill
    association :category
  end
end
