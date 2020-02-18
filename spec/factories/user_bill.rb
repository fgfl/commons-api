# frozen_string_literal: true

FactoryBot.define do
  factory :user_bill do
    sequence(:id) { |number| number }
    association :user
    association :bill
  end
end
