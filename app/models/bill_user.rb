class BillUser < ApplicationRecord
  belongs_to :bill
  belongs_to :user
end
