class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base

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
end
