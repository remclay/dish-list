class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, uniqueness: true

  has_one :list
end
