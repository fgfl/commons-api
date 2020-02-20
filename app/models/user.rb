class User < ApplicationRecord

  has_secure_password

  has_many :users_bills
  has_many :users_categories

  has_many :bills, :through => :users_bills
  has_many :categories, :through => :users_categories

  validates :name, presence: true
  validates :username, uniqueness: true, length: { minimum: 4 }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
