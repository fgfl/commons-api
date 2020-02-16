# frozen_string_literal: true

class Session < ApplicationRecord
  validates :number, presence: true
  validates :start_date, presence: true

  validate :start_date_is_date_object
  validate :end_date_is_date_object
  validate :start_date_must_be_in_the_past
  validate :end_date_must_be_in_the_future

  def start_date_is_date_object
    unless start_date.is_a?(Date)
      errors.add(:start_date, 'must be a Date object')
    end
  end

  def end_date_is_date_object
    errors.add(:end_date, 'must be a Date object') unless end_date.is_a?(Date)
  end

  def start_date_must_be_in_the_past
    if start_date.present? && start_date > Date.today
      errors.add(:start_date, 'must be in the past')
    end
  end

  def end_date_must_be_in_the_future
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, 'must be in the future')
    end
  end
end
