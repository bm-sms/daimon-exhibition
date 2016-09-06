class InquiryMailer < ApplicationMailer
  def thanks_for_your_inquiry(inquiry)
    @inquiry = inquiry

    mail to: inquiry.email
  end
end
