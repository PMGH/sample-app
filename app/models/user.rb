class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
end
