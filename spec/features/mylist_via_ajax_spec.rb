require 'rails_helper'

feature 'Mylist via Ajax', :js do
  let!(:product)        { create(:product) }
  let!(:secret_product) { create(:product, :secret) }

  background do
    visit root_path
  end

  scenario 'Add product to mylist' do
    mylist = add_product_to_mylist(product)

    expect(mylist).to eq('product' => [product.id])
  end

  scenario 'Remove product from mylist' do
    add_product_to_mylist(product)

    mylist = remove_product_from_mylist(product)

    expect(mylist).to eq('product' => [])
  end

  scenario 'Get products in mylist' do
    add_product_to_mylist(product)

    mylist = get_mylist

    expect(mylist).to eq('product' => [product.id])
  end

  scenario 'Allow deleting secret product request from mylist (however it ignored)' do
    mylist = remove_product_from_mylist(secret_product)

    expect(mylist).to eq('product' => [])
  end

  scenario 'Remove all products from mylist' do
    mylist = add_product_to_mylist(product)

    expect(mylist).to eq('product' => [product.id])

    mylist = remove_all_products_from_mylist

    expect(mylist).to eq('product' => [])
  end

  private

  def add_product_to_mylist(product)
    capture_ajax_response(
      url: mylist_product_path(product),
      method: 'POST',
      dataType: 'json'
    )
  end

  def remove_product_from_mylist(product)
    capture_ajax_response(
      url: mylist_product_path(product),
      method: 'DELETE',
      dataType: 'json'
    )
  end

  def remove_all_products_from_mylist
    capture_ajax_response(
      url: mylist_products_path,
      method: 'DELETE',
      dataType: 'json'
    )
  end

  def get_mylist
    capture_ajax_response(
      url: mylist_products_path,
      method: 'GET',
      dataType: 'json'
    )
  end

  def capture_ajax_response(ajax_option)
    success = "success_#{SecureRandom.hex(16)}"
    error   = "error_#{SecureRandom.hex(16)}"

    execute_script <<~JS
      $.ajax(#{ajax_option.to_json})
        .then(function(json) {
          window.#{success} = json;
        }, function(error) {
          window.#{error} = error;
        });
    JS
    wait_for_ajax

    ajax_failed = evaluate_script("window.#{error}")
    raise "Request failed: status=#{ajax_failed['status']}, response:\n  #{ajax_failed['responseText']}" if ajax_failed

    evaluate_script(success).tap do
      execute_script "delete window.#{success};"
    end
  end
end
