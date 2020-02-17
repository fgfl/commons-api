# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validates :uclassify_class, presence: true
end
