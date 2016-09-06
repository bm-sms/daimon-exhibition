class Inquiry < ApplicationRecord
  acts_as_inquiry to: :product

  has_many :inquiry_items
  has_many :products, through: :inquiry_items
end
