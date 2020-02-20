class User < ApplicationRecord

  has_secure_password

  has_many :bills, through: :user_bills
  has_many :categories, through: :user_categories

  validates :name, presence: true
  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

end
