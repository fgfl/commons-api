# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :session

  validates :code, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true
  validates :introduced_date, presence: true
  validates :page_url, presence: true
  validates :full_text_url, presence: true

  validate :introduced_date_is_date_object
  validate :introduced_date_must_not_be_in_the_future

  def introduced_date_is_date_object
    unless introduced_date.is_a?(Date)
      errors.add(:introduced_date, 'must be a Date object')
    end
  end

  def introduced_date_must_not_be_in_the_future
    if introduced_date.present? && introduced_date >= Date.today
      errors.add(:introduced_date, 'must not be in the future')
    end
  end
end
