# frozen_string_literal: true

class BillUser < ApplicationRecord
  belongs_to :bill
  belongs_to :user
end
