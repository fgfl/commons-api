class BillCategory < ApplicationRecord
  belongs_to :bill
  belongs_to :category
end
