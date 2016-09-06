require 'rails_helper'

feature 'Mylist', :js do
  background do
    create(:product,          name: 'Awesome product')
    create(:product, :secret, name: 'Secret product')
  end

  scenario 'Add product to mylist' do
    visit mylist_products_path
    expect(page).to have_content('There are not product yet.')

    visit products_path
    expect(page).to have_link('Awesome product')
    expect(page).to have_no_link('Secret product')

    click_on 'Awesome product'
    expect(page).to have_header('Awesome product')

    click_link 'Add this product to mylist'
    expect(page).to have_link('Remove this product from mylist')

    visit mylist_products_path
    expect(page).to have_header('Mylist')
    expect(page).to have_content('Awesome product')
  end

  scenario 'Remove product from mylist' do
    visit products_path

    click_on 'Awesome product'

    click_link 'Add this product to mylist'

    visit mylist_products_path
    expect(page).to have_header('Mylist')
    expect(page).to have_content('Awesome product')

    visit products_path

    click_on 'Awesome product'
    click_link 'Remove this product from mylist'
    expect(page).to have_link('Add this product to mylist')

    visit mylist_products_path
    expect(page).to have_content('There are not product yet.')
  end
end
