class User < ApplicationRecord
  # ApplicationRecord(abstract) inherits form ActiveRecord::Base
  validates :name, presence: true
end
