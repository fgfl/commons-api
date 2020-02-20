class User < ApplicationRecord

  has_secure_password

  has_many :bill_users
  has_many :category_users

  has_many :bills, through: :bill_users
  has_many :categories, through: :category_users

  validates :name, presence: true
  validates :username, uniqueness: true, length: { minimum: 4 }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
