# frozen_string_literal: true

class Category < ApplicationRecord

  has_many :bills_categories
  has_many :users_categories

  has_many :bills, :through => :bills_categories
  has_many :users, :through => :users_categories

  validates :name, presence: true, uniqueness: true
  validates :uclassify_class, presence: true, uniqueness: true
end
