class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new(inquiry_params)
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    @inquiry.save!

    InquiryMailer.thanks_for_your_inquiry(@inquiry).deliver_now

    mylist.clear

    redirect_to :root, notice: 'You inquiry is submitted.'
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(
      :name,
      :email,
      :product_ids => []
    )
  end
end
