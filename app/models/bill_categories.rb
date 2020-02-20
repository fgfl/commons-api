class BillCategories < ActiveRecord::Base
  belongs_to :bill
  belongs_to :category
end