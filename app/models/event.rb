class Event < ApplicationRecord
  belongs_to :bill

  validates :title, :presence => true
  validates :publication_date, :presence => true

  validate :publication_date_must_not_be_in_the_future

  def publication_date_must_not_be_in_the_future
    if publication_date.present? && publication_date >= Date.today
      errors.add(:publication_date, "must not be in the future")
    end
  end 
  
end
