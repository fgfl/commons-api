# frozen_string_literal: true

FactoryBot.define do
  factory :bill_user do
    sequence(:id) { |number| number }
    association :user
    association :bill
  end
end
