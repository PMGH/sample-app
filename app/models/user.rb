class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base
  validates :name, :email, presence: true
end
