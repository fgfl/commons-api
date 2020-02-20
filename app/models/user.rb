class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4 }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
