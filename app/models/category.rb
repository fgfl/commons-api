# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :uclassify_class, presence: true, uniqueness: true
end
