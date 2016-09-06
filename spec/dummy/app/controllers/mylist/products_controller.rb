class Mylist::ProductsController < ApplicationController
  acts_as_mylist :product, -> { Product.published }
end
