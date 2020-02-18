FactoryBot.define do

  factory :category do
    name { "The Thing that Does Stuff" }
  end

  factory :random_category, class: Category do
    name { Faker::TvShows::RickAndMorty.quote }
  end

end