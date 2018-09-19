class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # note regular expression above has one minor weakness: it allows invalid addresses that contain consecutive dots, such as foo@bar..com
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
end
