# frozen_string_literal: true

class CategoryUser < ApplicationRecord
  belongs_to :category
  belongs_to :user
end
