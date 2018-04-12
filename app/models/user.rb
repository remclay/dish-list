class User < ApplicationRecord
  has_secure_password
  validates :email, :password, presence: true
  validates :password, length: { in: 6..10 }
  validates :email, uniqueness: true

  has_one :list
end
