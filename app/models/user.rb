class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base

  attr_accessor :remember_token

  # Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Callbacks
  before_save { email.downcase! }

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # bcrypt password validation
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # return hash digest of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end
end
