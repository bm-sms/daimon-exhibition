class InquiryItem < ApplicationRecord
  belongs_to :inquiry
  belongs_to :product
end
