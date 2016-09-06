class ProductsController < ApplicationController
  def index
    @products = Product.published
  end

  def show
    @product = Product.published.find(params[:id])
  end
end
