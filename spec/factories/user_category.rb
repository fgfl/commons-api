# frozen_string_literal: true

FactoryBot.define do
  factory :user_category do
    sequence(:id) { |number| number }
    association :user
    association :category
  end
end
