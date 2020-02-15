class User < ApplicationRecord

  has_secure_password

  validates :email, :presence => true, :uniqueness => true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :name, :presence => true
  validates :password, :confirmation => true, length: { minimum: 5 }
  validates :password_confirmation, :presence => true

end
