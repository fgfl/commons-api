FactoryBot.define do
  factory :user_bill do
    association :user
    association :bill
  end
end
