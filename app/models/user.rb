class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, uniqueness: true
  validates :email, :email_format => { :message => "Please enter a valid email address"}

  has_one :list

  # Logged in via OAuth
  def self.find_or_create_by_omniauth(auth_hash)
    self.where(:email => auth_hash['info']['email']).first_or_create do |user|
      user.name = auth_hash['info']['name']
      user.password = SecureRandom.hex(10)
    end
  end
end
