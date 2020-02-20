# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bills, through: :bill_categories
  has_many :users, through: :user_categories

  validates :name, presence: true, uniqueness: true
  validates :uclassify_class, presence: true, uniqueness: true
end
