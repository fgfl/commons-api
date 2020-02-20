# frozen_string_literal: true

FactoryBot.define do
  factory :category_user do
    sequence(:id) { |number| number }
    user
    category
  end
end
