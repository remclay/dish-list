class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, uniqueness: true

  has_one :list

  # Logged in via OAuth
  def self.find_or_create_by_omniauth(auth_hash)
    self.where(:email => auth_hash['info']['email']).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
end
