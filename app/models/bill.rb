# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :session

  validates :code, presence: true, uniqueness: true
  validates :title, presence: true
  validates :page_url, presence: true

  validate :introduced_date_is_date_object_or_nil
  validate :introduced_date_must_not_be_in_the_future

  def introduced_date_is_date_object_or_nil
    if introduced_date.present? && !introduced_date.is_a?(Date)
      errors.add(:introduced_date, "must be a Date object")
    end
  end

  def introduced_date_must_not_be_in_the_future
    if introduced_date.present? && introduced_date > Date.today
      errors.add(:introduced_date, "must not be in the future")
    end
  end
end
