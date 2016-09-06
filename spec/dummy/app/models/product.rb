class Product < ApplicationRecord
  acts_as_exhibit

  scope :published, -> { where(secret: false) }
end
