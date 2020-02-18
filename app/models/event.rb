# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :bill

  validates :code, presence: true
  validates :title, presence: true
  validates :publication_date, presence: true

  validate :publication_date_is_date_object
  validate :publication_date_must_not_be_in_the_future

  def publication_date_is_date_object
    if !publication_date.is_a?(Date)
      errors.add(:publication_date, 'must be a Date object')
    end
  end

  def publication_date_must_not_be_in_the_future
    if publication_date.present? && publication_date >= Date.today
      errors.add(:publication_date, 'must not be in the future')
    end
  end
end
