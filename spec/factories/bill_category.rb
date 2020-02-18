FactoryBot.define do
  factory :bill_category do
    association :bill
    association :category
  end
end
