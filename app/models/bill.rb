class Bill < ApplicationRecord
  belongs_to :session

  validates :code, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :tabled_date, :presence => true
  validates :page_url, :presence => true
  validates :full_text_url, :presence => true

end
