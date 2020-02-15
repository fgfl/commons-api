class Event < ApplicationRecord
  belongs_to :bill

  validates :title, :presence => true
  validates :publication_date, :presence => true
end
