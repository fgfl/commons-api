class User < ApplicationRecord

  has_secure_password

  has_many :bills, through: :user_bills
  has_many :categories, through: :user_categories

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

end
