class Session < ApplicationRecord

  validates :number, :presence => true
  validates :start_date, :presence => true

  validate :start_date_must_be_in_the_past

  def start_date_must_be_in_the_past
    if start_date.present? && start_date > Date.today
      errors.add(:start_date, "must be in the past")
    end
  end   
  
end
