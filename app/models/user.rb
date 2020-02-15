class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

end
