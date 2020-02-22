FactoryBot.define do
  factory :user do
    sequence(:id) { |number| number }
    username { "JamesBB" }
    name { "James Brown" }
    email { "jamesbrown@dogs.com" }
    password_digest { "password" }
  end

  factory :random_user, class: User do
    sequence(:id) { |number| number }
    username { Faker::Superhero.name.gsub(/\s+/, "") }
    name { Faker::Name.name }
    email { Faker::Internet.safe_email }
    password { "password" }
    password_confirmation { "password" }
  end
end
