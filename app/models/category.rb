# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bill_categories
  has_many :category_users

  has_many :bills, through: :bill_categories
  has_many :users, through: :category_users

  validates :name, presence: true, uniqueness: true
  validates :uclassify_class, presence: true, uniqueness: true
end
