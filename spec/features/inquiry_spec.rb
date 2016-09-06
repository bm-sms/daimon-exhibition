require 'rails_helper'

feature 'Inquiry', :js do
  let!(:product_to_inquiry)     { create(:product, name: 'Awesome product') }
  let!(:product_not_to_inquiry) { create(:product, name: 'Normal product') }
  let!(:product_not_to_mylist)  { create(:product, name: 'Bad product') }

  background do
    add_product_to_mylist product_to_inquiry
    add_product_to_mylist product_not_to_inquiry
  end

  scenario 'with some products in mylist' do
    visit mylist_products_path
    uncheck 'Normal product'
    expect(page).to have_no_content('Bad product')
    click_on 'Inquiry with these products'

    expect(page).to have_content('Awesome product')
    expect(page).to have_no_content('Normal product')
    expect(page).to have_no_content('Bad product')

    fill_in 'Name',  with: 'Dave'
    fill_in 'Email', with: 'hi@example.com'
    click_on 'Submit'

    expect(page).to have_notice('You inquiry is submitted.')

    open_mail

    expect(current_mail.subject).to eq('Thanks for your inquiry')
    expect(current_mail.body.to_s).to include('Awesome product')
    expect(current_mail.body.to_s).not_to include('Normal product')
    expect(current_mail.body.to_s).not_to include('Bad product')
  end

  private

  def add_product_to_mylist(product)
    visit product_path(product)
    click_link 'Add this product to mylist'
  end

  def open_mail
    @current_mail = ActionMailer::Base.deliveries.pop
  end

  def current_mail
    @current_mail
  end
end
