# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:id) { |number| number }
    name { 'Business, industry and trade' }
    uclassify_class { 'business_industry' }
  end

  factory :random_category, class: Category do
    sequence(:id) { |number| number }
    name { Faker::Games::Pokemon.name }
    uclassify_class { Faker::Games::Zelda.game.underscore }
  end
end
